#!/bin/bash
DEVNAME="$1"
CURRENT=$(basename "$DEVNAME")

LOCKFILE="/run/procon-led.lock"
exec 200>"$LOCKFILE"
flock -n 200 || exit 0

# Collect all hidraw devices for Nintendo licensed controllers (0E6F:018C, Bluetooth bus 0005)
DEVICES=()
for uevent in /sys/class/hidraw/hidraw*/device/uevent; do
    if grep -q "HID_ID=0005:00000E6F:0000018C" "$uevent" 2>/dev/null; then
        HIDRAW=$(basename "$(dirname "$(dirname "$uevent")")")
        DEVICES+=("$HIDRAW")
    fi
done

# Sort by hidraw number to get consistent player order
IFS=$'\n' SORTED=($(printf '%s\n' "${DEVICES[@]}" | sort -V)); unset IFS

# Find player number of current device (1-indexed)
PLAYER=0
for i in "${!SORTED[@]}"; do
    if [ "${SORTED[$i]}" = "$CURRENT" ]; then
        PLAYER=$((i + 1))
        break
    fi
done

[ "$PLAYER" -eq 0 ] && exit 1
[ "$PLAYER" -gt 4 ] && PLAYER=4

# LED bitmasks: P1=0x01 P2=0x02 P3=0x04 P4=0x08
LED_MASKS=(0x01 0x02 0x04 0x08)
LED_MASK=${LED_MASKS[$((PLAYER - 1))]}

# Send Nintendo Switch HID output report 0x01, subcmd 0x30 (set player lights)
/usr/bin/env python3 -c "
import sys
data = bytes([0x01, 0x00, 0x00, 0x01, 0x40, 0x40, 0x00, 0x01, 0x40, 0x40, 0x30, $LED_MASK])
try:
    with open('$DEVNAME', 'wb') as f:
        f.write(data)
except PermissionError:
    sys.exit(1)
"
