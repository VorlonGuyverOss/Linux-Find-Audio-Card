#!/bin/env bash

set -x


BASE_CARD_LIMIT=4
DEVICE_LIMIT=10

device_left_status=2
device_right_status=2

for ((j - 0 ; j < $BASE_CARD_LIMIT ; j++ )); do

    for ((i = 0 ; i < $DEVICE_LIMIT ; i++)); do
        echo $device_left_status
        aplay -D plughw:$j,$i /usr/share/sounds/alsa/Front_Left.wav
        device_left_status=$?
        echo $device_left_status
        #sleep 5
        echo $device_right_status
        aplay -D plughw:$j,$i /usr/share/sounds/alsa/Front_Right.wav
        device_right_status=$?
        echo $device_right_status
        aplay -D plughw:$j,$i /usr/share/sounds/alsa/Front_Center.wav
    done

done


pacmd list cards | grep -e 'name:' -e 'alsa.device ' -e 'alsa.subdevice ' -e 'alsa.card '

pacmd list-sinks | grep -e 'name:' -e 'alsa.device ' -e 'alsa.subdevice '
