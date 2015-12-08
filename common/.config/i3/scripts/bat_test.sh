#!/usr/bin/env bash

SLEEP_TIME=5   # Default time between checks.
SAFE_PERCENT=95  # Still safe at this level.
DANGER_PERCENT=90  # Warn when battery at this level.
CRITICAL_PERCENT=85  # Hibernate when battery at this level.

NAGBAR_PID=
export DISPLAY=:0.0

function launchNagBar
{
    if [[ $NAGBAR_PID -eq "" ]]; then
        i3-nagbar -m 'Battery low!' -b 'Hibernate!' 'sudo physlock -s -u $USER & systemctl hibernate' >/dev/null 2>&1 &
    fi
    NAGBAR_PID=$(pgrep i3-nagbar)
}
function killNagBar
{
    if [[ $NAGBAR_PID -ne "" ]]; then
      kill $NAGBAR_PID
      NAGBAR_PID=
    fi
}

# main:
while [ true ]; do
    if [[ -n $(acpi -a | grep -i off-line) ]]; then
        rem_bat=$(acpi -b | grep -Eo "[0-9]+%" | grep -Eo "[0-9]+")
        if [[ $rem_bat -gt $SAFE_PERCENT ]]; then
            SLEEP_TIME=10
        else
            SLEEP_TIME=5
            if [[ $rem_bat -le $DANGER_PERCENT ]]; then
                SLEEP_TIME=2
                launchNagBar
            fi
            if [[ $rem_bat -le $CRITICAL_PERCENT ]]; then
                SLEEP_TIME=1
                sudo physlock -s -u $USER
                systemctl hibernate
            fi
        fi
    else
        SLEEP_TIME=10
        killNagBar
    fi
    sleep ${SLEEP_TIME}
done
