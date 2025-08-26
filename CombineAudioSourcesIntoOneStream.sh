#!/bin/env bash 

set -x


### Manual entry by Forrest J. Green to get my new Samsung dual screen audio to play on both
### monitors at the same time.

### Use the Method B tutorial for adding both monitors from
### https://askubuntu.com/questions/78174/play-sound-through-two-or-more-outputs-devices

#Device controller Owner module (found via pactl list) NOT USED HERE
#unload-module 7
echo $?

pacmd load-module module-alsa-sink device=hw:2,3 sink_name=hdmi1
#pacmd load-module module-alsa-sink device=hw:1,3 sink_name=hdmi1

#Device ID of Screen 2 HDMI card controller.  NOT USED HERE
#  WAS --> until a configuration change happened #pacmd load-module module-alsa-sink device=hw:1,8 sink_name=hdmi2
#pacmd load-module module-alsa-sink device=hw:3,8 sink_name=hdmi2
echo $?
#Using the combine module of PulseAudio to create a link for both monitor sound
###Through experimentation, we have to let the system create the automatic link
###and then in this shell script, dynamically combine Monitor 1 and 2's audio
pacmd load-module module-combine-sink sink_name=Dual_Monitor_Audio_1 slaves=hdmi1,alsa_output.pci-0000_03_00.1.hdmi-stereo-extra2 sink_properties=device.description=Dual_Monitor_Audio
#pacmd load-module module-combine-sink sink_name=Dual_Monitor_Audio_2 slaves=hdmi2,alsa_output.pci-0000_03_00.1.hdmi-stereo sink_properties=device.description=Dual_Monitor_Audio
echo $?
#set the default audio stream
pacmd set-default-sink Dual_Monitor_Audio_1
#pacmd set-default-sink Dual_Monitor_Audio_2
echo $?



# Troubleshooting tips:
#pacmd list cards | grep -e 'name:' -e 'alsa.device ' -e 'alsa.subdevice ' -e 'alsa.card '

#pacmd list-sinks | grep -e 'name:' -e 'alsa.device ' -e 'alsa.subdevice '

#aplay -D plughw:3,8 /usr/share/sounds/alsa/Front_Right.wav && aplay -D plughw:0,0 /usr/share/sounds/alsa/Front_Right.wav

#pactl list cards

#pacmd list-sources | grep -e 'name: '
