# Cat Flight V1 Audio

Approved audio is assigned by scripts at runtime; no audition selectors remain.
License details: `assets/audio/licenses/AUDIO_LICENSES.md`.

- Player FlapSound: `assets/audio/sfx/sfx_flap.wav`, once per flap while alive, -12 dB.
- Main ScoreSound: `assets/audio/sfx/sfx_score.wav`, once per normal point, -10 dB.
- At positive multiples of 10, ScoreSound uses `sfx_meow.wav` instead of the normal
  score sound. They do not play together.
- Main DeathSound: `assets/audio/sfx/sfx_death.wav`, once per death, -10 dB.

SFX do not loop. Death stops flap/score playback; scene reload recreates the SFX
players. Adjust node Volume dB values to tune the mix.

## Main BGM

MusicManager Autoload holds one AudioStreamPlayer for `assets/audio/bgm/bgm_main.wav`.
Each run starts it from 0:00 at -5 dB. The WAV uses native forward looping.
Death fades it out over 0.2 seconds and stops it. Game Over has no BGM/jingle.
Restart cancels the old fade and starts the track from the beginning.
MusicManager exports `bgm_volume_db` and `death_fade_duration` for tuning.

## Current effective gameplay tuning

The saved Main scene overrides standalone script fallback defaults:

- Player gravity: 900 px/s²; flap strength: 330 px/s.
- Main obstacle speed: 200 px/s; spawn interval: 2.0 seconds; gap height: 185 px.
- Obstacle visual/collision width: 80 px; nominal pair spacing: 400 px.
- Logical viewport: 480 × 720; stretch: `canvas_items`; aspect: `expand`.
- Game Over delays: HIT 0.9 seconds; BONK 0.9 seconds; SQUASH 0.4 seconds.
