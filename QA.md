# TASK-010 — V1 QA

Date: 2026-10-04. Engine: Godot 4.7.2 on Windows.

## Result

V1 is technically ready for replacing placeholder art and assigning final audio
streams. Human playtesting and listening remain necessary before final acceptance.
No features were added and no commit was made.

## Actual gameplay values

The saved main scene overrides the script defaults. Those manual values were
preserved and tested:

| Value | Effective setting |
| --- | --- |
| Gravity | 900 px/s² |
| Flap strength | 330 px/s |
| Obstacle speed | 200 px/s |
| Spawn interval | 2 seconds |
| Gap size | 185 px |
| Obstacle width | 70 px |
| Base viewport | 480 × 720 |

## Tested

- Gravity integration and simulated physical Space/left mouse button input.
- Repeated Timer spawning, random gaps, geometry/hitbox alignment, speed,
  partially visible obstacle retention and fully offscreen cleanup.
- Safe gap passage and real physics overlap with both top and bottom obstacles;
  ceiling/ground boundary detection and the three original death reasons.
- No early points, one point per passed pair, duplicate prevention, current/best
  score labels and immediate high-score saving.
- Game Over UI, disabled dead controls, frozen obstacles/spawning and guarded
  duplicate deaths. Hit/bonk deformation, completed downward falls and ground squash.
- Twenty button-signal restarts: score, player state/position, obstacles, timer,
  game-over reason and quotes reset; best score retained.
- Background changes without adjacent repeats and varied quotes from the central
  list; every quote's label minimum height fits the UI.
- Missing, malformed, negative, wrong-type and missing-key save fallback; a new
  process loads the saved record and a lower score does not overwrite it.
- Empty audio streams and flap/score/death playback hooks with a temporary silent
  stream; death stops flap/score playback and cannot replay its sound.
- 201 automated checks passed after the fix, plus two cross-process persistence
  checks. Tests used a separate project/save directory; the actual high score was
  not replaced with test data.
- Rendered and inspected gameplay/death screenshots at 480 × 720. Rendered and
  inspected Game Over layouts at 360 × 640 and 720 × 1280. Checked background
  coverage, panel containment and ground alignment after resizing, including a
  resize while a death tween was active. Used the configured D3D12 Forward+
  renderer; a Compatibility renderer capture also succeeded before the fix.
- Original project loaded in the headless editor and ran for 1,200 fixed-rate
  frames. No game runtime errors observed. Final whitespace check passed.

The headless display reports a 64 × 64 window. Automated logical-layout checks
fixed its viewport to 480 × 720; actual resize/render checks used a real game window.
An initial test-exit object warning disappeared after the test harness waited for
animations and disposed of its test scene; it was not reproduced in the game.

## Bug fixed

After a completed death reaction, resizing to a different portrait aspect ratio
left the player at the old floor height. `scripts/player.gd` now snaps to the
current floor when the reaction finishes and when a completed dead player sees a
viewport resize. The original reason, disabled controls and game-over flow remain.

## Remaining manual checks

- Play several runs with real keyboard/mouse input and click Restart, including
  immediately during a death reaction; assess the manually tuned difficulty.
- Watch animation timing and collisions in motion. Static rendered screenshots
  were inspected; this was not a human gameplay session.
- Review readability, contrast and UI obstruction across all backgrounds and on
  the intended phone/window sizes. Confirm final artwork aligns with hitboxes.
- Assign real short audio streams using AUDIO.md, then listen for volume balance,
  timing, repeated flaps and restart interruption. No actual audio was auditioned.
- Mobile-device input/performance and export behavior were not tested.
