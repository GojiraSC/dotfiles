#!/bin/bash

# Check if ProtonVPN is connected
if ip link show | grep -q "proton"; then
    echo " 󱢾 "  # Connected icon
else
    echo " 󰦞 "  # Disconnected icon
fi
