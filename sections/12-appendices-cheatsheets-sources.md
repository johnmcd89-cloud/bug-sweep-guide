# 12) Appendices: cheat sheets + sources

## A) Command cheat sheets (copy/paste)

### A.1 HackRF sweeps

Reference:
- https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

```bash
# Sub‑GHz sweep (tailor to your region)
hackrf_sweep -f 300:928 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/sweep_300_928.csv

# 2.4 GHz slice
hackrf_sweep -f 2400:2485 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/sweep_2p4.csv
```

Helper script in this repo:

```bash
./scripts/hackrf_sweep_log.sh 300 928
```

### A.2 Wi‑Fi recon

Kismet:

```bash
sudo kismet
```

iw scan:

```bash
sudo iw dev
sudo iw dev wlan0 scan | less
```

References:
- https://www.kali.org/tools/kismet/
- https://www.kali.org/tools/iw/

### A.3 BLE recon

```bash
bluetoothctl
# inside:
power on
scan on
```

References:
- https://www.kali.org/tools/bluez/
- https://www.kali.org/tools/bettercap/

### A.4 Network inventory + diffs

```bash
# inventory
./scripts/nmap_inventory.sh 192.168.8.0/24

# diff the two latest scans
./scripts/ndiff_latest.sh
```

Reference:
- https://www.kali.org/tools/nmap/

### A.5 Traffic capture + summarize

```bash
sudo tcpdump -i wlan0 -w /tmp/capture.pcap
sudo tshark -r /tmp/capture.pcap -q -z conv,tcp
```

References:
- https://www.kali.org/tools/tcpdump/
- https://www.wireshark.org/docs/man-pages/tshark.html

## B) Interpretation guide (quick)

- Prefer **baseline vs. change** over one-off observations.
- Strong signal ≠ malicious. Confirm via proximity/localization.
- If you can’t explain a signal, log it and revisit later.

## C) Source list (citation-ready)

1. Great Scott Gadgets — HackRF overview: https://greatscottgadgets.com/hackrf/
2. HackRF ReadTheDocs — HackRF tools (`hackrf_sweep`): https://hackrf.readthedocs.io/en/latest/hackrf_tools.html
3. PortaPack Mayhem firmware repo: https://github.com/portapack-mayhem/mayhem-firmware
4. PortaPack Mayhem wiki/manual: https://github.com/portapack-mayhem/mayhem-firmware/wiki
5. Flipper docs — Sub‑GHz: https://docs.flipper.net/zero/sub-ghz
6. Flipper docs — CLI: https://docs.flipper.net/zero/development/cli
7. Kali tools — Kismet: https://www.kali.org/tools/kismet/
8. Aircrack-ng docs index: https://www.aircrack-ng.org/documentation.html
9. Kali tools — bettercap: https://www.kali.org/tools/bettercap/
10. Kali tools — BlueZ: https://www.kali.org/tools/bluez/
11. Kali tools — iw: https://www.kali.org/tools/iw/
12. Kali tools — nmap: https://www.kali.org/tools/nmap/
13. Kali tools — tcpdump: https://www.kali.org/tools/tcpdump/
14. Wireshark man page — tshark: https://www.wireshark.org/docs/man-pages/tshark.html
