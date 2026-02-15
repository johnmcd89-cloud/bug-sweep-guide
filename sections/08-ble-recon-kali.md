# 08) BLE reconnaissance on Kali (BlueZ + bettercap)

BLE (Bluetooth Low Energy) devices are common in hotels and homes (locks, trackers, TVs, beacons). Like Wi‑Fi recon, BLE recon is mostly about **inventory + change detection**.

## 8.1 BlueZ / bluetoothctl (baseline tool)

BlueZ provides the Linux Bluetooth stack and utilities.

- Kali tool page: https://www.kali.org/tools/bluez/

Quick workflow:

```bash
bluetoothctl
# inside:
power on
scan on
```

What to record:
- device name (often generic)
- MAC address
- RSSI (if available) and how it changes as you move

## 8.2 bettercap BLE recon (optional)

bettercap is a recon framework that includes BLE reconnaissance modules.

- Kali tool page: https://www.kali.org/tools/bettercap/

Use only **recon** features unless you’re on equipment you own/operate with explicit authorization.

## 8.3 What to look for

- **New BLE devices** that appear only when you enter a specific room.
- Devices with strong signal that persists (could still be benign; treat as an indicator).
- Repeat appearances over time (helpful for baselines).

Best practice:
- Use **baseline vs. change**: scan at home, then scan in travel environments.
- Localize via **proximity** (RSSI changes with distance) and physical sweep.

## References

- BlueZ: https://www.kali.org/tools/bluez/
- bettercap: https://www.kali.org/tools/bettercap/
