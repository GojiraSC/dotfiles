#!/bin/bash

# Wait for PipeWire/audio to be ready (max 15 seconds)
for i in {1..15}; do
    if pactl info &>/dev/null && [ -n "$(pactl list short sinks 2>/dev/null)" ]; then
        break
    fi
    sleep 1
done

bars="▁▂▃▄▅▆▇█"
/usr/sbin/cava -p ~/.config/cava/waybar.conf | while read -r line; do
  output=""
  IFS=";" read -ra vals <<< "$line"
  for v in "${vals[@]}"; do
    output+="${bars:$v:1}"
  done
  echo "$output"
done
