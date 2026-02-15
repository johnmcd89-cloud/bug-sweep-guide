# 06) Flipper Zero workflows (receive-only recon + CLI logging)

Flipper Zero is best used as a **fast triage** tool. It can tell you “something is active in common sub‑GHz bands” and help you capture basic RF observations, but it is not a universal bug detector.

## 6.1 Where it fits (and where it doesn’t)

Good for:
- quick “is anything chatty?” checks in **300–928 MHz** range
- recognizing common remote-like activity
- keeping lightweight notes/logs about activity you observe

Not good for:
- proving something is a surveillance device
- identifying passive cameras (no RF)
- anything that requires transmitting in a non-authorized environment

## 6.2 Sub‑GHz receive-only posture

Treat transmission/emulation as out-of-scope unless you’re on your own property with explicit authorization.

Flipper Sub‑GHz reference:
- https://docs.flipper.net/zero/sub-ghz

Practical advice:
- Use Flipper to **listen first**.
- If you see recurring activity, follow up with **HackRF logging** and **localization** techniques.

## 6.3 CLI logging (basic automation hook)

Flipper’s CLI lets you pull device info and automate repeatable actions (depending on firmware/app state).

CLI reference:
- https://docs.flipper.net/zero/development/cli

Workflow:

1) Connect over USB.
2) Open the CLI session.
3) Use `help` to discover available commands.
4) Record:
   - firmware version
   - time/location/context
   - what you observed (band, activity pattern)

Even if you don’t automate deep capture, CLI is useful for **repeatability** and “runbook” style checklists.

## 6.4 Safety/legality reminders

- Don’t transmit in hotels/public spaces.
- Don’t attempt to interfere with others’ devices.

## References

- Sub‑GHz docs: https://docs.flipper.net/zero/sub-ghz
- CLI docs: https://docs.flipper.net/zero/development/cli
