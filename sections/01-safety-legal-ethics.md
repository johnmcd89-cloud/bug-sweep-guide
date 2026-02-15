# 01) Safety, legal, and ethics

This guide is written for **defensive, receive-only recon** and for checking **your own spaces, gear, and networks**.

## Legal reality check

Rules vary by country/state. As a general principle:

- **Intercepting communications content** (decoding/recording private radio, Wi‑Fi traffic you don’t own/operate, etc.) can be illegal without authorization.
- **Transmitting** on many bands (including “just to test”) may require licensing and can violate local law.
- **Jamming** and **Wi‑Fi deauthentication** are illegal in many places and can impact other people’s safety and property.

When traveling, treat most environments (hotels, rentals, venues) as **non-authorized** unless you have explicit permission.

## Safety (don’t make things worse)

- Prefer **passive measurement** (scanning, observing, logging) over any active interaction.
- Avoid powering unknown devices with your own adapters/cables.
- If you find something suspicious, prioritize **documentation** (photos, location, timestamps) over experimenting with it.

## Scope + limitations (avoid false certainty)

There is no magic “bug detector.” Many malicious devices are:

- **Passive** (recording to SD; no RF emission)
- **Bursting** (only transmit intermittently)
- **Wired** (power + Ethernet) or piggybacking legitimate Wi‑Fi

RF environments are noisy (Wi‑Fi/BLE, LTE, DECT, building systems). The workflow in this guide is designed around:

- **Baseline vs. change detection** (what’s new when you plug/unplug something)
- **Proximity tests** (closer = stronger) and **localization** (directional antennas / attenuation)

## Operating posture

- Default to **receive-only** on Flipper and SDR gear.
- If you need deeper analysis, do it in a controlled environment you own.
- Treat outputs as *indicators*, not proof.

## References

- HackRF overview: https://greatscottgadgets.com/hackrf/
