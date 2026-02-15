# 09) Network inventory + anomaly detection (nmap / ndiff / tcpdump / tshark)

When you can get devices onto a network you control (e.g., via a travel router), network tooling is one of the most reliable ways to spot suspicious activity.

The core idea is simple:

- **Inventory** what’s on the LAN.
- **Diff** inventories over time.
- **Capture** traffic when something looks off.

## 9.1 Inventory with nmap

nmap can enumerate hosts and services. Save outputs so you can compare later.

Reference:
- https://www.kali.org/tools/nmap/

Example inventory scan (tailor subnet):

```bash
mkdir -p ~/bug-sweep/nmap
sudo nmap -sV -O -oX ~/bug-sweep/nmap/scan_$(date +%F_%H%M).xml 192.168.8.0/24
```

Tips:
- Use consistent scan options if you intend to diff results.
- Be mindful: aggressive scans can annoy fragile IoT devices.

### Diff scans (ndiff)

nmap supports comparing results with ndiff (concept referenced in nmap docs).

Workflow:
- keep two XMLs
- compare changes (new hosts, new ports, changed fingerprints)

## 9.2 Traffic capture (tcpdump)

If you suspect a device is streaming/uploading, capture traffic for a short window.

Reference:
- https://www.kali.org/tools/tcpdump/

Example:

```bash
mkdir -p ~/bug-sweep/pcap
sudo tcpdump -i wlan0 -w ~/bug-sweep/pcap/capture_$(date +%F_%H%M).pcap
```

## 9.3 Summaries and analysis (tshark)

tshark can summarize top talkers/conversations, filter by host, and extract protocol details.

Reference:
- https://www.wireshark.org/docs/man-pages/tshark.html

Examples:

```bash
# Conversation summary
sudo tshark -r ~/bug-sweep/pcap/capture.pcap -q -z conv,tcp

# DNS query summary
sudo tshark -r ~/bug-sweep/pcap/capture.pcap -q -z io,phs -Y dns
```

## 9.4 What to look for

Indicators that deserve follow-up:

- Unknown device with **open RTSP/HTTP admin** ports.
- Sustained outbound uploads to unknown IPs/domains.
- Repeated periodic DNS lookups (“beaconing”).
- A device that appears only when a suspicious object is powered.

## 9.5 Safe automation idea

- Run a daily/periodic nmap inventory on your travel-router LAN.
- Alert on diffs (new hosts, new services).
- If a diff is detected, trigger a short tcpdump capture and summarize with tshark.

## References

- nmap: https://www.kali.org/tools/nmap/
- tcpdump: https://www.kali.org/tools/tcpdump/
- tshark: https://www.wireshark.org/docs/man-pages/tshark.html
