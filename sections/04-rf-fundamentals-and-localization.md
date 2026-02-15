# 04) RF fundamentals + localization methods

RF work is where people waste the most time, because **normal environments are noisy**. The goal is not to stare at waterfalls—it’s to build confidence by combining:

- **baseline vs. change detection**
- **proximity tests** (closer = stronger)
- **localization tools** (directional antennas, attenuation, near-field probes)

## 4.1 Reality check: what RF can and can’t tell you

- If a device is **passive** (records to SD) it may emit nothing.
- If a device **bursts**, you may miss it unless you log over time.
- Many “spikes” are benign (Wi‑Fi/BLE, LTE, DECT, building systems).

Treat RF as an **indicator** that helps you localize a source—not a proof of surveillance.

## 4.2 The workflow: baseline → isolate variables → localize

### Step 1: build a baseline

- Sweep the room with as many devices off/unplugged as feasible.
- Note time and place. Hotels and apartments have different RF profiles.

### Step 2: change one variable

- Plug in or power on a suspicious device.
- Sweep again and look for **new, persistent carriers**.

### Step 3: localize

Once you have a candidate signal:

- **Move closer/farther**: does it rise/fall with proximity?
- **Rotate your antenna**: does directionality change intensity?
- **Attenuate**: add attenuation or reduce gain so you can get closer without saturating.

## 4.3 Overload is your enemy (front-end saturation)

If everything looks “hot,” you may be overloading the receiver.

Mitigations:
- Reduce gain.
- Add a **step attenuator**.
- Use a smaller antenna or move farther away.

## 4.4 Localization tools (in order of usefulness)

### 1) Directional antennas

A directional antenna turns “RF in the room” into “RF over there.”

- 2.4/5.8 GHz patch/Yagi is high leverage.
- Sub‑GHz directionality is harder; use proximity + attenuation.

### 2) Attenuation

A step attenuator helps you get close to a transmitter without saturating.

### 3) Near-field probes

Near-field probes let you “touch scan” electronics/cables to find what’s actually radiating.

## 4.5 Practical sweep bands (high-level)

You’ll generally spend time in:
- Sub‑GHz ISM (varies by region; many consumer devices)
- 2.4 GHz (Wi‑Fi/BLE)
- 5 GHz (Wi‑Fi)

When you need a repeatable scan, use HackRF logging sweeps.

## 4.6 Loggable sweeps with HackRF (repeatability)

For repeatable scans and later diffs, `hackrf_sweep` is the workhorse.

Reference (tools + usage/output):
- https://hackrf.readthedocs.io/en/latest/hackrf_tools.html

Example pattern:

```bash
mkdir -p ~/bug-sweep/rf

# Sweep a band and save CSV (tailor gain/range/bin-width)
hackrf_sweep -f 300:928 -w 1000000 -l 16 -g 20 > ~/bug-sweep/rf/sweep_300_928.csv
```

Interpretation suggestions:
- Run the same sweep multiple times and compare.
- Flag “new peaks” above baseline rather than chasing one-off hits.

## References

- HackRF overview: https://greatscottgadgets.com/hackrf/
- HackRF tools (`hackrf_sweep`): https://hackrf.readthedocs.io/en/latest/hackrf_tools.html
