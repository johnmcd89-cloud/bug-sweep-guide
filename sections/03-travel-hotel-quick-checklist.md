# 03) Travel & hotel quick checklist

This is the “do it in 10–20 minutes” workflow. It’s optimized for **defensive discovery** without doing anything illegal or disruptive.

## 3.1 The priority order

1) **Physical sweep** (fast, high-signal)
2) **Local device discovery** (Wi‑Fi + BLE reconnaissance)
3) **RF sweep** (only if you see indicators; use baselines + localization)
4) **Network inventory / traffic checks** (best if you use a travel router you control)

## 3.2 Physical sweep (always first)

**Targets:** anything with a good view of bed/shower/desk.

- Smoke detectors, clocks, vents, mirrors facing the room
- “Free” USB chargers, power strips, alarm clocks
- TV set-top boxes / HDMI dongles / streaming sticks
- Anything newly placed or oddly positioned

**Quick optical tricks:**
- Darken the room and use a phone camera to look for **IR LEDs** (many cameras use IR illumination).
- Use a strong flashlight at a shallow angle to spot pinhole lenses.

If something feels off, **document** it (photos, position, time) before touching it.

## 3.3 Device discovery (Wi‑Fi + BLE)

### Option A (recommended): create a network you control

Bring a **travel router** and put your devices on it. This gives you a clean LAN you can inventory and monitor.

### Option B: use the hotel network (less reliable)

Even if you can’t see other guests’ devices, you can still:
- enumerate APs nearby
- look for suspicious SSIDs (e.g., camera-like names)
- scan for BLE devices in the room

#### Wi‑Fi reconnaissance (passive-first)

- Kismet is excellent for mapping APs/clients over time and logging.
  - Kali package: https://www.kali.org/tools/kismet/

If you have a monitor-mode capable adapter:

```bash
# Start Kismet server (example)
sudo kismet
```

If you don’t, you can still do basic scans:

```bash
# Enumerate Wi-Fi networks
sudo iw dev
sudo iw dev wlan0 scan | less
```

Reference: https://www.kali.org/tools/iw/

#### BLE reconnaissance

Use BlueZ (`bluetoothctl`) for a simple, reliable scan:

```bash
bluetoothctl
# inside:
power on
scan on
# watch devices appear
```

Reference: https://www.kali.org/tools/bluez/

Optional: bettercap can run a BLE recon module (use recon-only features):
- https://www.kali.org/tools/bettercap/

## 3.4 RF sweep (only if you have indicators)

RF sweeps are most useful when you can do **baseline vs. change**.

### Fast method (PortaPack walk-around)

- Do a quick sweep/waterfall to identify persistent carriers.
- Move closer/farther to see whether signal strength changes with proximity.

### Loggable method (HackRF on Kali)

Use `hackrf_sweep` to log a frequency range and compare later.

- HackRF tools reference: https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

```bash
# Example sweep; tailor for region and performance.
hackrf_sweep -f 300:928 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/hotel_300_928.csv
```

**Interpretation tips:**
- If everything looks “hot,” you may be overloading: reduce gain and/or add attenuation.
- A real target is usually something you can **localize** by walking around (signal rises as you approach).

## 3.5 Network inventory (best on your travel router)

If you have a LAN you control (travel router), run an inventory and look for unexpected services.

```bash
# Inventory hosts + services (example)
sudo nmap -sV -O -oX ~/bug-sweep/nmap/hotel_lan.xml 192.168.8.0/24
```

Reference: https://www.kali.org/tools/nmap/

For traffic suspicion (uploads/beacons), capture and summarize:

```bash
# Capture (example interface)
sudo tcpdump -i wlan0 -w ~/bug-sweep/pcap/hotel.pcap

# Summarize / inspect with tshark
sudo tshark -r ~/bug-sweep/pcap/hotel.pcap -q -z conv,tcp
```

References:
- tcpdump: https://www.kali.org/tools/tcpdump/
- tshark: https://www.wireshark.org/docs/man-pages/tshark.html

## 3.6 If you find something suspicious

- Don’t transmit, deauth, jam, or try to “hack back.”
- Document evidence, isolate your own devices, and consider changing rooms / escalating to appropriate authorities.

## References

- HackRF overview: https://greatscottgadgets.com/hackrf/
- HackRF tools (`hackrf_sweep`): https://hackrf.readthedocs.io/en/latest/hackrf_tools.html
- Kismet: https://www.kali.org/tools/kismet/
- iw: https://www.kali.org/tools/iw/
- BlueZ: https://www.kali.org/tools/bluez/
- bettercap: https://www.kali.org/tools/bettercap/
- nmap: https://www.kali.org/tools/nmap/
- tcpdump: https://www.kali.org/tools/tcpdump/
- tshark: https://www.wireshark.org/docs/man-pages/tshark.html
