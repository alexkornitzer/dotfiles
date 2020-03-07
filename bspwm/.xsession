#!/usr/bin/bash

list=( $(ls -1 ${HOME}/.66/conf/boot-user) )
for i in ${list[@]};do
    var=$(<${HOME}/.66/conf/boot-user/${i})
    for j in ${var[@]}; do
		export ${j}
    done
done

66-all up

