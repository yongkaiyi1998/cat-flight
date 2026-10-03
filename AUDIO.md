# Placeholder audio hooks

No audio assets are included yet. The game stays silent until streams are assigned.

In the Godot Inspector, drag a short WAV or OGG asset into the **Stream** field:

- `scenes/player.tscn` → `FlapSound`: plays for each flap while alive.
- `scenes/main.tscn` → `ScoreSound`: plays when an obstacle pair awards one point.
- `scenes/main.tscn` → `DeathSound`: plays once for any death reason.

Leave Autoplay and looping off. Adjust each node's Volume dB as needed. FlapSound
starts at -12 dB; ScoreSound and DeathSound start at -10 dB. Empty streams are
skipped safely. Death stops flap and score playback, and restarting disposes of
all old sound players along with the old scene.

## Movement defaults

Tune these exported values in the Inspector:

- Player: `fall_gravity = 900` px/s², `flap_strength = 330` px/s.
- Main: `obstacle_speed = 170` px/s, `spawn_interval = 2.0` seconds,
  `gap_size = 240` px.
- ObstaclePair: `obstacle_width = 70` px. Main supplies speed and gap size
  for spawned pairs; its values override the pair's standalone defaults.

The slightly gentler gravity and flap retain roughly the previous flap height
(about 60 px), with a slower arc. Obstacles move a little slower and have a wider
gap. The two-second spawn interval is retained, giving 340 px between pairs.
These are initial tuning choices; playtesting may suggest further adjustments.
