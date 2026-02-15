# 02) Setup from scratch (your loadout)

This section gets your kit into a **known-good, repeatable** state so your sweeps are comparable across time and locations.

## 2.1 Core principles

- Prefer **receive-only** defaults.
- Create a **baseline** in a known environment (your home) so you can recognize “normal.”
- Log everything (timestamps, location notes, frequency ranges, scan settings) so you can compare later.

## 2.2 HackRF + PortaPack H4M

### Firmware / software

- Decide your PortaPack firmware (e.g., Mayhem) and keep a note of versions.
  - Mayhem firmware repo: https://github.com/portapack-mayhem/mayhem-firmware
  - Mayhem wiki/manual: https://github.com/portapack-mayhem/mayhem-firmware/wiki

### Antennas / adapters (minimum viable kit)

- Sub‑GHz whip suitable for ~300–928 MHz (SMA as needed).
- 2.4 GHz antenna for quick checks (a small whip is fine at first).
- Carry SMA adapters (male/female, SMA↔RP‑SMA) so you’re not dead in the field.

### Kali-side tooling checklist

On Kali (Pi CM5 or laptop), install HackRF tooling and confirm the device is recognized.

Key reference for tools and `hackrf_sweep` usage/output:
- https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

**Create a logging folder:**

```bash
mkdir -p ~/bug-sweep/{rf,pcap,nmap,kismet,notes}
```

**First “sanity sweep” (loggable):**

Run a sweep over common consumer bands and save output; repeat later to compare.

```bash
# Example only — tailor frequency ranges to your region.
# Run multiple smaller sweeps rather than one giant sweep if performance is limited.
hackrf_sweep -f 300:928 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/home_baseline_300_928.csv
```

Notes:
- Run a baseline with as many local emitters off as practical.
- If you see “solid walls” of RF, you may be overloading the front-end; reduce gain and/or add attenuation.

## 2.3 Flipper Zero

### Sub‑GHz receive-only posture

Flipper is useful for quick triage in common sub‑GHz ranges; treat it as an indicator tool, not proof.

- Sub‑GHz docs: https://docs.flipper.net/zero/sub-ghz

### CLI access (for logging + automation hooks)

- CLI docs: https://docs.flipper.net/zero/development/cli

Minimal workflow:
- Connect via USB.
- Use `help` to enumerate available commands on your firmware.
- Record device/firmware versions in your notes.

## 2.4 Kali on Raspberry Pi CM5

### Wi‑Fi tooling

- Kismet (wireless discovery/WIDS logging): https://www.kali.org/tools/kismet/
- Aircrack-ng docs index (passive capture tooling): https://www.aircrack-ng.org/documentation.html
- iw (interface/channel/regdomain): https://www.kali.org/tools/iw/

### BLE tooling

- BlueZ (`bluetoothctl`): https://www.kali.org/tools/bluez/
- bettercap (includes `ble.recon` module): https://www.kali.org/tools/bettercap/

### Network inventory + capture tooling

- nmap (scan + diff concepts): https://www.kali.org/tools/nmap/
- tcpdump: https://www.kali.org/tools/tcpdump/
- tshark reference: https://www.wireshark.org/docs/man-pages/tshark.html

## 2.5 Recommended “field upgrades” (high leverage)

These items dramatically improve your ability to separate signal from noise:

- **Directional antennas** (2.4/5.8 patch/Yagi) + sub‑GHz antenna options
- **Step attenuator** (prevents overload when close to a transmitter)
- **Near-field probe set** (touch-probing electronics/cables)
- **Travel router** (creates a LAN you control and can scan/diff)
- **Monitor-mode capable Wi‑Fi adapter** (Pi built-in Wi‑Fi may be limiting)
- Strong flashlight + small inspection mirror; phone camera for IR LED spotting

## 2.6 Baseline checklist (do this at home)

- [ ] Record firmware/software versions for HackRF/PortaPack/Flipper/Kali tools.
- [ ] Create logging directories.
- [ ] Run and save a baseline `hackrf_sweep` in a quiet-ish environment.
- [ ] Run a Wi‑Fi discovery session (Kismet) and export/save results.
- [ ] Run an `nmap` inventory of your home LAN and save results for later diffs.

