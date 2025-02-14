#!/usr/bin/env python
# -*- coding: UTF-8 -*-
from __future__ import print_function

import sys
import re
import shlex
from subprocess import Popen, PIPE, check_output


def get_tagname_or_hash():
    """return tagname if exists else hash"""
    cmd = 'git log -1 --format="%h%d"'
    output = check_output(shlex.split(cmd)).decode('utf-8').strip()
    hash_, tagname = None, None
    # get hash
    m = re.search('\(.*\)$', output)
    if m:
        hash_ = output[:m.start() - 1]
    # get tagname
    m = re.search('tag: .*[,\)]', output)
    if m:
        tagname = 'tags/' + output[m.start() + len('tag: '): m.end() - 1]

    if tagname:
        return tagname
    elif hash_:
        return hash_
    return None


# Re-use method from https://github.com/magicmonty/bash-git-prompt to get stashs count
def get_stash():
    cmd = Popen(['git', 'rev-parse', '--git-dir'], stdout=PIPE, stderr=PIPE)
    so, se = cmd.communicate()
    stash_file = '%s%s' % (so.decode('utf-8').rstrip(), '/logs/refs/stash')

    try:
        with open(stash_file) as f:
            return sum(1 for _ in f)
    except IOError:
        return 0


# `git status --porcelain --branch` can collect all information
# branch, remote_branch, untracked, staged, changed, conflicts, ahead, behind
po = Popen(['git', 'status', '--porcelain', '--branch'], stdout=PIPE, stderr=PIPE)
stdout, sterr = po.communicate()
if po.returncode != 0:
    sys.exit(0)  # Not a git repository

# collect git status information
untracked, staged, changed, conflicts = [], [], [], []
ahead, behind = 0, 0
# Remove « .decode('utf-8') » because it breaks status line if an accent (e.g.: « é ») is present.
# For example, with .decode('utf-8'), git-prompt does not display with this kind of branch name: « feature/8113_liens_supplémentaires »
# was: « status = [(line[0], line[1], line[2:]) for line in stdout.decode('utf-8').splitlines()] »
status = [(line[0], line[1], line[2:]) for line in stdout.decode('utf-8').splitlines()]
for st in status:
    if st[0] == '#' and st[1] == '#':
        if re.search('Initial commit on', st[2]):
            branch = st[2].split(' ')[-1]
        elif re.search('no branch', st[2]):  # detached status
            branch = get_tagname_or_hash().split(",")[0]
        elif len(st[2].strip().split('...')) == 1:
            branch = st[2].strip()
        else:
            # current and remote branch info
            branch, rest = st[2].strip().split('...')
            if len(rest.split(' ')) == 1:
                # remote_branch = rest.split(' ')[0]
                pass
            else:
                # ahead or behind
                divergence = ' '.join(rest.split(' ')[1:])
                divergence = divergence.lstrip('[').rstrip(']')
                for div in divergence.split(', '):
                    if 'ahead' in div:
                        ahead = int(div[len('ahead '):].strip())
                    elif 'behind' in div:
                        behind = int(div[len('behind '):].strip())
    elif st[0] == '?' and st[1] == '?':
        untracked.append(st)
    else:
        if st[1] == 'M':
            changed.append(st)
        if st[0] == 'U':
            conflicts.append(st)
        elif st[0] != ' ':
            staged.append(st)

stashed = get_stash()
if not changed and not staged and not conflicts and not untracked and not stashed:
    clean = 1
else:
    clean = 0

out = ', '.join([
    branch,
    str(ahead),
    str(behind),
    str(len(staged)),
    str(len(conflicts)),
    str(len(changed)),
    str(len(untracked)),
    str(stashed),
    str(clean)
])
print(out, end='')
