#!/bin/sh

printf "Content-type: application/json\r\n\r\n"
printf "{\n"
printf "\"%s\":\"%s\"\\n" "error" "false"
printf "}\n"

# Yeah, it's pretty ugly.. but hey, it works.

sync
sync
sync
killall -q mqtt-sonoff
sleep 1
reboot
