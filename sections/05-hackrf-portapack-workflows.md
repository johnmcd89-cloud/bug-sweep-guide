# 05) HackRF + PortaPack workflows

This is the core RF lane:

- **PortaPack** is for fast, on-foot, “what’s in this room?” checks.
- **HackRF on Kali** is for repeatable logging, comparison, and longer dwell times.

## 5.1 PortaPack first-pass workflow (walk-around)

Goal: quickly identify **persistent** signals and get an initial bearing.

Suggested approach:

1) Start with a **wide sweep / waterfall** view.
2) If you see a strong, stable carrier, do a **proximity test**:
   - walk closer/farther
   - rotate your body/antenna
   - note whether the signal changes consistently
3) If the display looks saturated (everything bright), reduce gain / add attenuation.

PortaPack ecosystem reference:
- Mayhem firmware repo: https://github.com/portapack-mayhem/mayhem-firmware
- Mayhem wiki/manual: https://github.com/portapack-mayhem/mayhem-firmware/wiki

## 5.2 HackRF sweep logging (repeatability)

When you want evidence you can compare later, log sweeps with `hackrf_sweep`.

Reference for tools + `hackrf_sweep` options/output fields:
- https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

### Recommended logging structure

```bash
mkdir -p ~/bug-sweep/rf
```

Keep a simple naming convention:

- `home_baseline_<band>_<date>.csv`
- `hotel_room_<band>_<date>.csv`
- `suspect_device_on_<band>_<date>.csv`

### Example sweep patterns

**Sub‑GHz sweep (common consumer ranges; tailor for region):**

```bash
hackrf_sweep -f 300:928 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/sweep_300_928.csv
```

**2.4 GHz slice (Wi‑Fi/BLE heavy; useful for localization, not attribution):**

```bash
hackrf_sweep -f 2400:2485 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/sweep_2p4.csv
```

Notes:
- If you’re CPU-limited on the Pi, reduce sweep width or bin resolution.
- Avoid drawing strong conclusions from a single sweep—repeat and compare.

## 5.3 Baseline vs. change detection (the practical method)

RF bug-hunting works best as a science experiment:

1) **Baseline** sweep: room as “quiet” as practical.
2) **Change one variable**: plug in/power on a suspicious item.
3) Sweep again and look for **new peaks** or persistent carriers.

If a candidate appears, immediately move to localization:

- get closer/farther
- rotate antenna
- add attenuation
- use directional antenna

## 5.4 Localization playbook

### Directional antenna (high leverage)

- Use a 2.4/5.8 patch/Yagi when working those bands.
- Take multiple readings from different angles.

### Attenuation (to avoid overload and “pinpoint”)

As you get closer, add attenuation so you can still see meaningful gradient.

### Near-field probes (for electronics)

If you can legally/ethically inspect a device, a near-field probe can help answer:

- is this object emitting, or is the RF coming from somewhere else?

## 5.5 What to do when you find a suspicious emission

- Don’t transmit/jam/deauth.
- Document frequency, approximate location, and how signal strength changes with proximity.
- If it’s a hotel/travel context: prioritize your safety and escalation over experimentation.

## References

- HackRF overview: https://greatscottgadgets.com/hackrf/
- HackRF tools (`hackrf_sweep`): https://hackrf.readthedocs.io/en/latest/hackrf_tools.html
- PortaPack Mayhem: https://github.com/portapack-mayhem/mayhem-firmware
