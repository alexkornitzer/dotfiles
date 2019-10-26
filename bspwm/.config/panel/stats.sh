#!/usr/bin/env bash
##!/usr/bin/env dash

# TODO: Remove unnecessary use of grep/awk/sed

# Helpers
cpu_total() {
  local total=0
  for i in $@; do
    let "total+=${i}"
  done
  echo $total
}

# Status functions
_bandwidth() {
  # TODO:
  echo "  "
}

_battery() {
  local bat=$(cat /sys/class/power_supply/BAT0/capacity)
  printf "  %3.0f%% " "${bat}"
}

_cpu() {
  local p_cpu=( $(cat /proc/stat | grep '^cpu ') )
  unset p_cpu[0]
  local p_idle=${p_cpu[4]}
  local p_total=$(cpu_total ${p_cpu[@]})
  sleep 1
  local c_cpu=( $(cat /proc/stat | grep '^cpu ') )
  unset c_cpu[0]
  local c_idle=${c_cpu[4]}
  local c_total=$(cpu_total ${c_cpu[@]})
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

_time() {
  echo " $(date +%H:%M)"
}

_volume() {
  # TODO:
  echo "    0% "
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
  echo "S$(_vpn)$(_lan)$(_wifi)$(_bandwidth)$(_disk)$(_memory)$(_cpu)$(_battery)$(_volume)$(_date)$(_time)"
  # sleep 1;
done
