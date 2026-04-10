# hid-nintendo-licensed-led

Automatic player LED assignment for Nintendo-licensed Bluetooth controllers on Linux (vendor `0E6F`).

When a controller connects, it automatically gets assigned player 1, 2, 3 or 4 based on connection order — no manual setup needed.

## Tested on

- Turtle Beach Rematch (Donkey Kong edition) — `0E6F:018C`

If your controller has vendor ID `0E6F` and uses the Nintendo Switch HID protocol, it should work.

## How it works

A udev rule triggers on Bluetooth HID device connection. A script sends a Nintendo Switch HID output report (`0x01`, subcmd `0x30`) to set the player LED based on the controller's position among connected devices.

## CLI Usage

### Automatic (udev)

When a controller connects, it automatically gets assigned player 1–4 based on connection order.

### Manual

```bash
# List connected controllers and their player assignment
procon-led.sh --list

# Force a specific player LED on a controller
procon-led.sh --set-player 2 /dev/hidraw1
```

## Installation

### Via AUR

```bash
yay -S hid-nintendo-licensed-led
```

### Manually

```bash
git clone https://github.com/Kyworn/hid-nintendo-licensed-led.git
cd hid-nintendo-licensed-led
sudo install -Dm755 procon-led.sh /usr/local/bin/procon-led.sh
sudo install -Dm644 99-nintendo-licensed-led.rules /usr/lib/udev/rules.d/99-nintendo-licensed-led.rules
sudo udevadm control --reload-rules
```

## Requirements

- `python`
- A Nintendo-licensed Bluetooth controller with vendor ID `0E6F`

## License

MIT
