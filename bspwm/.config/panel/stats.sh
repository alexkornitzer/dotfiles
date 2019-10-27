#!/usr/bin/env bash

set -e

# TODO: Remove unnecessary use of grep/awk/sed

# Helpers
_cpu_total() {
  local total=0
  for i in $@; do
    let "total+=${i}"
  done
  echo $total
}

_parse_volume() {
  # Grab Mono or Front Left
  awk "/\[(on|off)\]/ {gsub(/\[|\]/, \"\"); \
    if (\$1 == \"Mono:\") {
      if (\$6 == \"off\") {
        printf \"   0%\";
      } else { printf \"  \";
        printf \"%3.0u%\", \$4;
      }
    } else if (\$2 == \"Left:\") {
      if (\$6 == \"off\") {
        printf \"   0%\";
      } else { printf \"  \";
        printf \"%3.0u%\", \$5;
      }
    }
  }"
}

# Status functions
_bandwidth() {
  local interface=$(ip route | awk '/^default/ { print $5 ; exit }')
  [[ -z "$interface" ]] && return
  local path="/dev/shm/$(basename $0)-${interface}"
  read rx < "/sys/class/net/${interface}/statistics/rx_bytes"
  read tx < "/sys/class/net/${interface}/statistics/tx_bytes"
  local time=$(date +%s)
  if ! [[ -f "${path}" ]]; then
    echo "${time} ${rx} ${tx}" > "${path}"
    chmod 0666 "${path}"
  fi
  read old < "${path}"
  echo "${time} ${rx} ${tx}" > "${path}"
  old=(${old//;/ })
  time_diff=$(( $time - ${old[0]} ))
  [[ "${time_diff}" -gt 0 ]] || return
  rx_diff=$(( $rx - ${old[1]} ))
  tx_diff=$(( $tx - ${old[2]} ))
  rx_rate=$(( $rx_diff / $time_diff ))
  tx_rate=$(( $tx_diff / $time_diff ))
  rx_kib=$(( $rx_rate >> 10 ))
  tx_kib=$(( $rx_rate >> 10 ))
  # TODO: Handle MB/s
  printf " %3.0fKB/s  %3.0fKB/s " $tx_kib $rx_kib
}

_battery() {
  local bat=$(cat /sys/class/power_supply/BAT0/capacity)
  printf "  %3.0f%% " "${bat}"
}

_cpu() {
  local p_cpu=( $(cat /proc/stat | grep '^cpu ') )
  unset p_cpu[0]
  local p_idle=${p_cpu[4]}
  local p_total=$(_cpu_total ${p_cpu[@]})
  sleep 1
  local c_cpu=( $(cat /proc/stat | grep '^cpu ') )
  unset c_cpu[0]
  local c_idle=${c_cpu[4]}
  local c_total=$(_cpu_total ${c_cpu[@]})
  let "idle=${c_idle}-${p_idle}"
  let "total=${c_total}-${p_total}"
  let "usage=(1000*(${total}-${idle})/${total}+5)/10"
  printf "  %3.0f%% " "${usage}"
}

_date() {
  echo " $(date +%d/%m/%y) "
}

_disk() {
  local home="$(df -k /home)"
  printf "  %3.0f%% " "$(expr "$home" : '.* \([0-9]\?[0-9]\?[0-9]\?\)%')"
}

_lan() {
  [ "$(ip addr show ens33 2>/dev/null)" ] && echo " "
}

_memory() {
  local memfree=`cat /proc/meminfo | grep MemFree | awk '{print $2}'`;
  local memtotal=`cat /proc/meminfo | grep MemTotal | awk '{print $2}'`;
  printf " %3.0f%% " "$((($memtotal - $memfree) * 100 / $memtotal))"
}

_temperature() {
  local core="$(sensors | grep 'Package id' | cut -d " " -f 5)"
  local temp="$(expr "$core" : '.*+\([0-9]\?[0-9]\?[0-9]\?\).')"
  printf " %3.0f° " "$temp"
}

_time() {
  echo " $(date +%H:%M)"
}

_volume() {
  local vol=$(amixer -D default get Master | _parse_volume)
  echo "%{A:amixer -q -D pulse set 'Master' toggle>/dev/null:}${vol}%{A} "
}

_vpn() {
  [ "$(ip addr show vpn0 2>/dev/null)" ] && echo " "
}

_wifi() {
  if [ "$(ip addr show wlan0 2>/dev/null)" ]; then
    local quality=$(grep wlan0 /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
    printf "  %3.0f%% " "${quality}"
  fi
}

# Print the percentage
while true; do
  echo "S$(_vpn)$(_lan)$(_wifi)$(_bandwidth)$(_disk)$(_temperature)$(_memory)$(_cpu)$(_battery)$(_volume)$(_date)$(_time)"
  # sleep 1;
done
