# 07) Wi‑Fi reconnaissance on Kali (Kismet / aircrack-ng / iw)

Wi‑Fi recon is often more actionable than RF waterfall watching because you can observe:

- nearby SSIDs/APs (including suspicious “camera-like” SSIDs)
- channel usage and signal strength
- device appearance over time (new MACs)

This section focuses on **passive mapping** and **defensive inventory**, not interference.

## 7.1 Hardware note (monitor mode matters)

Many of the best workflows require a Wi‑Fi adapter that supports **monitor mode** reliably. The Pi’s built-in Wi‑Fi may be limiting.

## 7.2 Kismet (best default)

Kismet is a wireless discovery/WIDS framework that can log and show devices over time.

- Kali tool page: https://www.kali.org/tools/kismet/

Typical workflow:

1) Put your adapter into a mode Kismet can use (Kismet docs cover this).
2) Start Kismet.
3) Let it run long enough to catch bursty devices.
4) Export/save logs for later comparison.

Example start:

```bash
sudo kismet
```

## 7.3 aircrack-ng suite (mapping via monitor mode)

Aircrack-ng provides a set of tools often used for capture and analysis. For this guide, focus on **passive capture**.

Docs index:
- https://www.aircrack-ng.org/documentation.html

Common flow:

```bash
# Enable monitor mode (varies by chipset)
sudo airmon-ng start wlan0

# Passive capture/map
sudo airodump-ng wlan0mon
```

Avoid deauth/injection workflows unless you’re on a network you own/operate with explicit authorization.

## 7.4 iw (ground truth for interfaces + scanning)

`iw` is a reliable tool for inspecting wireless interfaces, supported modes, and performing basic scans.

- Kali tool page: https://www.kali.org/tools/iw/

Examples:

```bash
# Show devices
sudo iw dev

# Scan (requires managed mode; output can be long)
sudo iw dev wlan0 scan | less
```

## 7.5 What to look for (signal, not noise)

- **New devices appearing** shortly after you enter a room (could be benign; treat as an indicator).
- SSIDs that look like camera/NVR vendors, or “hidden” SSIDs with strong RSSI in-room.
- Repeated association/disassociation patterns.

Best practice: compare against your baseline and use **proximity** (RSSI changes as you move around).

## References

- Kismet: https://www.kali.org/tools/kismet/
- aircrack-ng docs: https://www.aircrack-ng.org/documentation.html
- iw: https://www.kali.org/tools/iw/
