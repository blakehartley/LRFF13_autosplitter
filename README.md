# LRFF13 Autosplitter

[**日本語のREADMEはこちら/Read in Japanese**](README.ja.md)

A LiveSplit autosplitter (ASL) for **LIGHTNING RETURNS: FINAL FANTASY XIII** (Steam).

Created by Roosta ([@blakehartley](https://github.com/blakehartley)) and taken over by
[@a-ki-yoshi](https://github.com/a-ki-yoshi).

## Features

- **Timer start**: timed as in the Speedrun.com rules
- **Timer stop**: timed as in the Speedrun.com rules
- **Splits**: see "Usage" below for how to set them up
- **Load removal (LRT)**: measures the time without loads and shows it as Game Time
- **Text display**: shows the last battle time, the last menu time and the encounter count in
  Text components

## Usage

1. In LiveSplit, open **Edit Splits**, set the game name to `Lightning Returns: Final Fantasy XIII`
   and click **Activate**
2. In **Settings**, turn the checkboxes for the split points on or off
3. Make as many segments as the splits you turned on, and put them in order

Ready-to-use sample .lss files for Any% are also included. After loading one, turn on the
matching splits in **Settings**.

- [lrff13_any_sample.lss](lrff13_any_sample.lss) (English)
- [lrff13_any_sample_ja.lss](lrff13_any_sample_ja.lss) (Japanese)
- [lrff13_any_sample_enja.lss](lrff13_any_sample_enja.lss) (English and Japanese)

[RTAGamers](https://rtagamers.com/rta-tools/autotimer/#toc7) explains the steps with screenshots
(in Japanese).

If the splits look a few frames late, try raising LiveSplit's own refresh rate
(right click → Settings → Refresh Rate) to 60 or more.

Even so, the timing can be off by a frame or more. This cannot be fully fixed, so please bear
with it.

### Showing the battle time and the others

1. In LiveSplit, open **Edit Layout** and add a **Text** (+ → Information → Text) for each kind of
   value you want to show
2. In the **Settings** of **Edit Splits**, turn on the ones you use: "Override text component with
   a Fight Timer", "Override text component with a Menu Timer" and "Override text component with
   an Encounter Counter"
3. Start the game (if it is already running, restart the game or LiveSplit)
