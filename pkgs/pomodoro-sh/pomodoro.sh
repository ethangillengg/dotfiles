#!/bin/sh

# Default values
break_time="5m"
work_time="25m"

# Check arguments
for arg in "$@"
do
    case $arg in
        -b=*)
        break_time="${arg#*=}"
        shift
        ;;
        -w=*)
        work_time="${arg#*=}"
        shift
        ;;
    esac
done

while true
do
  notify-send "Time to Work!" -i pomodoro-start-light
  timer -n "Work" -f $work_time || break
  notify-send "Take a Break!" -i pomodoro-stop-light
  timer -n "Break" -f $break_time || break
done
