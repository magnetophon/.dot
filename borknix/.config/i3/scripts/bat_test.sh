#!/usr/bin/env bash

SLEEP_TIME=5   # Default time between checks.
SAFE_PERCENT=90  # Still safe at this level.
DANGER_PERCENT=85  # Warn when battery at this level.
CRITICAL_PERCENT=80  # Hibernate when battery at this level.

# in minutes
SAFE_TIME=30  # Still safe at this level.
DANGER_TIME=25  # Warn when battery at this level.
CRITICAL_TIME=20  # Hibernate when battery at this level.

NAGBAR_PID=
export DISPLAY=:0.0

function launchNagBar
{
    NAGBAR_PID=$(pgrep i3-nagbar)
    if [[ $NAGBAR_PID -eq "" ]]; then
        i3-nagbar -m 'Battery low!' -b 'Hibernate!' 'lockandHibernate' >/dev/null 2>&1 &
    fi
    NAGBAR_PID=$!
}
function killNagBar
{
    NAGBAR_PID=$(pgrep i3-nagbar)
    if [[ $NAGBAR_PID -ne "" ]]; then
        kill $NAGBAR_PID
        NAGBAR_PID=
    fi
}
function lockandHibernate
{
    sudo physlock -s -u $USER
    systemctl suspend
    # systemctl hybrid-sleep
    #systemctl hibernate
}

# main:
while [ true ]; do
    #if [[ -n $(acpi -a | grep -i off-line) ]]; then
    if [[ $(cat /sys/class/power_supply/AC0/online) -eq 0 ]]; then
        #rem_bat=$(acpi -b | grep -Eo "[0-9]+%" | grep -Eo "[0-9]+")
        #rem_bat=$(cat /sys/class/power_supply/BAT0/capacity)
        rem_time=$(acpi -b | awk '{print $(NF-1)}')
        hrs=$(date --date="$rem_time" +%H)
        mins=$(date --date="$rem_time" +%M)
        rem_mins=$(((hrs*60)+mins))
        #if [[ $rem_bat -gt $SAFE_PERCENT ]]; then
        #SLEEP_TIME=10
        #else
        #SLEEP_TIME=5
        #if [[ $rem_bat -le $DANGER_PERCENT ]]; then
        #SLEEP_TIME=2
        #launchNagBar
        #fi
        #if [[ $rem_bat -le $CRITICAL_PERCENT ]]; then
        #SLEEP_TIME=1
        #lockandHibernate
        #fi
        #fi

        if [[ $rem_mins -gt $SAFE_TIME ]]; then
            SLEEP_TIME=10
        else
            SLEEP_TIME=5
            if [[ $rem_mins -le $DANGER_TIME ]]; then
                SLEEP_TIME=2
                launchNagBar
            fi
            if [[ $rem_mins -le $CRITICAL_TIME ]]; then
                SLEEP_TIME=1
                # double check, to prevent too sudden shutdowns
                if [[ $rem_bat -le $CRITICAL_PERCENT ]]; then
                    lockandHibernate
                fi
            fi
        fi
    else
        SLEEP_TIME=10
        killNagBar
    fi
    sleep ${SLEEP_TIME}
done
