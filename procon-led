#!/bin/bash

LOCKFILE="/run/procon-led.lock"
LED_MASKS=(0x01 0x02 0x04 0x08)

# Collect all hidraw devices for Nintendo licensed controllers (0E6F:018C, Bluetooth bus 0005)
collect_devices() {
    local DEVICES=()
    for uevent in /sys/class/hidraw/hidraw*/device/uevent; do
        if grep -q "HID_ID=0005:00000E6F:0000018C" "$uevent" 2>/dev/null; then
            local HIDRAW=$(basename "$(dirname "$(dirname "$uevent")")")
            DEVICES+=("$HIDRAW")
        fi
    done
    IFS=$'\n' printf '%s\n' "${DEVICES[@]}" | sort -V
    unset IFS
}

# Set player LED on a device
set_led() {
    local DEVNAME="$1"
    local PLAYER="$2"

    if [ "$PLAYER" -lt 1 ] || [ "$PLAYER" -gt 4 ]; then
        echo "Error: player must be 1-4" >&2
        exit 1
    fi

    local LED_MASK=${LED_MASKS[$((PLAYER - 1))]}

    exec 200>"$LOCKFILE"
    flock -n 200 || exit 0

    /usr/bin/env python3 -c "
import sys
data = bytes([0x01, 0x00, 0x00, 0x01, 0x40, 0x40, 0x00, 0x01, 0x40, 0x40, 0x30, $LED_MASK])
try:
    with open('$DEVNAME', 'wb') as f:
        f.write(data)
except PermissionError:
    sys.exit(1)
"
}

# Auto mode: assign players by connection order
auto_assign() {
    local DEVNAME="$1"
    local CURRENT=$(basename "$DEVNAME")

    exec 200>"$LOCKFILE"
    flock -n 200 || exit 0

    local DEVICES
    mapfile -t DEVICES < <(collect_devices)

    # Find player number of current device (1-indexed)
    local PLAYER=0
    for i in "${!DEVICES[@]}"; do
        if [ "${DEVICES[$i]}" = "$CURRENT" ]; then
            PLAYER=$((i + 1))
            break
        fi
    done

    [ "$PLAYER" -eq 0 ] && exit 1
    [ "$PLAYER" -gt 4 ] && PLAYER=4

    local LED_MASK=${LED_MASKS[$((PLAYER - 1))]}

    /usr/bin/env python3 -c "
import sys
data = bytes([0x01, 0x00, 0x00, 0x01, 0x40, 0x40, 0x00, 0x01, 0x40, 0x40, 0x30, $LED_MASK])
try:
    with open('$DEVNAME', 'wb') as f:
        f.write(data)
except PermissionError:
    sys.exit(1)
"
}

# --list: show connected controllers
list_controllers() {
    local DEVICES
    mapfile -t DEVICES < <(collect_devices)

    if [ ${#DEVICES[@]} -eq 0 ]; then
        echo "No Nintendo-licensed controllers connected."
        return
    fi

    echo "Connected controllers:"
    for i in "${!DEVICES[@]}"; do
        local PLAYER=$((i + 1))
        [ "$PLAYER" -gt 4 ] && PLAYER=4
        echo "  Player $PLAYER  /dev/${DEVICES[$i]}"
    done
}

# Parse arguments
case "$1" in
    --list)
        list_controllers
        ;;
    --set-player)
        if [ -z "$2" ] || [ -z "$3" ]; then
            echo "Usage: procon-led.sh --set-player <1-4> /dev/hidrawX" >&2
            exit 1
        fi
        set_led "$3" "$2"
        ;;
    --help|-h)
        echo "Usage:"
        echo "  procon-led.sh /dev/hidrawX              Auto-assign player LED"
        echo "  procon-led.sh --list                    List connected controllers"
        echo "  procon-led.sh --set-player <1-4> /dev/hidrawX  Set specific player"
        ;;
    "")
        echo "Error: missing device path. Use --list or --help." >&2
        exit 1
        ;;
    *)
        # Default: auto mode (called by udev with /dev/hidrawX)
        auto_assign "$1"
        ;;
esac
