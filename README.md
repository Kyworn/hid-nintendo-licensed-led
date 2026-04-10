# hid-nintendo-licensed-led

> Automatic player LED assignment for Nintendo-licensed Bluetooth controllers on Linux.

Connect up to 4 controllers and each one gets automatically assigned its player LED (P1, P2, P3, P4) — just like on a real Nintendo Switch. No manual setup, no fiddling around.

## Features

- **Plug & Play** — player LED is set automatically on connection
- **Smart ordering** — players are assigned by connection order, consistently
- **Race condition safe** — concurrent connections are handled via `flock`
- **CLI override** — manually set player LEDs when you need to
- **Zero configuration** — install, connect, play

## Tested on

| Controller | Vendor:Product | Status |
|---|---|---|
| Turtle Beach Rematch (Donkey Kong edition) | `0E6F:018C` | ✅ Works |
| PDP Faceoff Deluxe | `0E6F:018C` | ✅ Works (reported) |

If your controller has vendor ID `0E6F` and uses the Nintendo Switch HID protocol, it should work out of the box.

## Screenshots

<!-- TODO: add gif showing LEDs lighting up on connect -->

## How it works

```
Controller connects (Bluetooth)
       ↓
udev rule detects new hidraw device (0005:0E6F:018C)
       ↓
procon-led script runs with flock (prevents race conditions)
       ↓
Scans all connected controllers, determines player position
       ↓
Sends Nintendo Switch HID report (0x01, subcmd 0x30)
       ↓
Player LED lights up ✨
```

## CLI Usage

### Automatic (udev)

Nothing to do — the udev rule handles it on connection.

### Manual override

```bash
# List connected controllers
$ procon-led --list
Connected controllers:
  Player 1  /dev/hidraw8
  Player 2  /dev/hidraw9
  Player 3  /dev/hidraw10

# Force a controller to a specific player
$ procon-led --set-player 2 /dev/hidraw10
```

## Installation

### AUR

```bash
yay -S hid-nintendo-licensed-led
```

### Manual

```bash
git clone https://github.com/Kyworn/hid-nintendo-licensed-led.git
cd hid-nintendo-licensed-led
sudo install -Dm755 procon-led /usr/bin/procon-led
sudo install -Dm644 99-nintendo-licensed-led.rules /usr/lib/udev/rules.d/99-nintendo-licensed-led.rules
sudo udevadm control --reload-rules
```

Then reconnect your controller.

## Requirements

- `python` (for the HID report)
- `util-linux` (for `flock`, already installed on Arch)
- A Nintendo-licensed Bluetooth controller with vendor ID `0E6F`

## Troubleshooting

**LED doesn't light up?**
- Make sure Bluetooth pairing is done (controller shows in `bluetoothctl`)
- Check that the udev rule is loaded: `udevadm control --reload-rules`
- Try manual assignment: `procon-led --set-player 1 /dev/hidrawX`

**Wrong player order?**
- Disconnect all controllers, reconnect in the desired order
- Or use `--set-player` to override manually

## License

MIT — see [LICENSE](LICENSE)
