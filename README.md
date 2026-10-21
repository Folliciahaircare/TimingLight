# Timing Light

A floating speech timer for Toastmasters-style presentations (8-minute talks). Floats above full-screen Google Slides during Zoom presentations with green/yellow/red threshold lights and a soft bell alert.

## Quick Start

**On Mac:** Double-click `Start Timing Light.command`
- Opens Chrome automatically
- Serves the timer on `http://127.0.0.1:8123`
- Leave the Terminal window open while presenting

## Files

- **`index.html`** — Self-contained timer page (all CSS/JS/audio embedded)
- **`Start Timing Light.command`** — Double-clickable launcher (starts local server, opens Chrome)

## Features

- **Duration presets:** 1, 5, 8, 10, 20 min or custom (1–120); thresholds scale to 75% / 87.5% / 100%
- **Threshold lights (8-min default):**
  - 🟢 Green: 6:00 (speaker time is good)
  - 🟡 Yellow: 7:00 (time to wrap up)
  - 🔴 Red: 8:00 (time is up, pulses on overtime)
- **Float above slides:** Picture-in-Picture mode for presenting over Slides
- **Sound alerts:** Bell toll or synth chime (toggle on/off, adjust volume)
- **Customizable:** Edit threshold times, colors, or sounds directly in the timer

## How it works

The timer runs on `http://127.0.0.1:8123` (not `file://`) because Picture-in-Picture and other browser APIs require a real HTTP origin. The launcher script handles server startup automatically.

## Showing the timer to the Zoom audience

1. Start the timer with the launcher and click **⧉ Float above slides**.
2. In Zoom, click **Share Screen** and pick **Entire Screen** (not just the Slides window), then tick **Share sound** so the bell is heard.
3. Start Slides fullscreen. The floating timer stays above it and is part of the shared screen.

To keep the timer private, share only the Slides window instead.

## Browser support

- **Chrome** (recommended, default in launcher)
- **Safari** (use launcher script, not file:// directly)

## Customization

- Edit **Green/Yellow/Red time inputs** on the timer page (default 6:00 / 7:00 / 8:00)
- Upload **custom bell sound** via the sound panel
- Modify **colors** by editing CSS hex values in `index.html`

## Troubleshooting

**"Float above slides" doesn't work:**
- Make sure you're using the launcher script (Chrome over HTTP), not opening the file directly
- Check address bar shows `http://127.0.0.1:8123/...`, not `file:///...`

**Bell sound doesn't play:**
- Click 🔔 to toggle sound on
- Check volume slider is above 0%
- Click ▶ Test to preview the current sound

**No browser opens:**
- Check Python 3 is installed: `python3 --version`
- Check Terminal window for error messages

## Development notes

- Self-contained HTML file: no build process, no external dependencies
- Canvas-based drawing converted to video stream for Picture-in-Picture
- Audio embedded as base64 (no external files needed)
- Explicit `<meta charset="UTF-8">` for proper emoji rendering

For full technical details, see `~/Claude/BNIHEAT11-IT/TIMING_LIGHT_HANDOFF.md`
