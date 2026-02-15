# 10) Automation recipes + scripts

Automation makes this workflow usable. The goal is to turn "weird vibes" into **repeatable evidence**:

- scheduled sweeps
- saved inventories
- diffs over time
- alerts on change

This section includes simple scripts you can run on Kali.

## 10.1 RF sweep logger + change detection

### Log a sweep

Use `hackrf_sweep` to log a band to CSV.

Reference:
- https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

Script (in this repo): `scripts/hackrf_sweep_log.sh`

```bash
./scripts/hackrf_sweep_log.sh 300 928
```

### Detect change (simple approach)

A practical v1 is to:

- run a baseline sweep at home
- run a sweep in the target environment
- compare peaks manually at first

Later, you can automate peak extraction and diffing (e.g., Python script that buckets by MHz and flags new maxima above threshold).

## 10.2 Wi‑Fi/BLE “new device” alerting

Two strategies:

- Long-running tools that log and then you parse logs (e.g., Kismet for Wi‑Fi).
- Lightweight periodic scans with diffs (works better when you control the LAN).

Kismet reference:
- https://www.kali.org/tools/kismet/

BlueZ reference:
- https://www.kali.org/tools/bluez/

## 10.3 Network inventory diff (nmap + ndiff)

Script (in this repo): `scripts/nmap_inventory.sh`

```bash
./scripts/nmap_inventory.sh 192.168.8.0/24
```

Diff the two latest scans:

```bash
./scripts/ndiff_latest.sh
```

Reference:
- https://www.kali.org/tools/nmap/

## 10.4 Traffic volume anomaly (top talkers)

Capture for 1–5 minutes when you detect something suspicious, then summarize:

```bash
sudo tcpdump -i wlan0 -w /tmp/capture.pcap
sudo tshark -r /tmp/capture.pcap -q -z conv,tcp
```

References:
- tcpdump: https://www.kali.org/tools/tcpdump/
- tshark: https://www.wireshark.org/docs/man-pages/tshark.html

## 10.5 Suggested “automation loop” (travel router LAN)

1) Inventory: run nmap scan and store XML.
2) Diff: if new host/port appears, alert.
3) Capture: do a short tcpdump capture.
4) Summarize: tshark top talkers/destinations.

