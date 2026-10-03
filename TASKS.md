# Cat Flight — V1 Tasks

## Status

V1 target: approximately 15 hours total.

Goal by Hour 5:
A complete playable loop must exist.

---

## TASK-001 — Basic Player Flight

Status: NEXT

- Create the main gameplay scene.
- Create a player scene.
- Use placeholder graphics.
- Apply gravity.
- Mouse click / Space makes the player flap upward.
- Keep important movement values easy to tune.
- Game should run successfully.

No obstacles yet.

---

## TASK-002 — Obstacles

- Create obstacle pair scene.
- Move obstacles from right to left.
- Randomize vertical gap position.
- Spawn obstacle pairs repeatedly.
- Remove obstacles after leaving the screen.

---

## TASK-003 — Collision and Game Over

- Detect obstacle collision.
- Detect ceiling collision.
- Detect ground collision.
- Stop normal gameplay after death.
- Track death reason.

---

## TASK-004 — Score and Restart

- +1 when successfully passing an obstacle pair.
- Display current score.
- Add Game Over state.
- Add fast restart.

At completion of this task, the full core gameplay loop must work.

---

## TASK-005 — High Score

- Save local high score.
- Load it when the game starts.
- Display current and best score.

---

## TASK-006 — Random Backgrounds

- Randomly choose a background at the beginning of each run.
- Use placeholders initially.
- Avoid immediately repeating the previous background if practical.

---

## TASK-007 — Death Reactions

Implement three simple reactions:

- obstacle / wall hit
- ceiling hit
- ground hit

Keep implementation simple and replaceable by final art later.

---

## TASK-008 — Death Quotes

- Display one random funny quote after death.
- Keep quotes in an easy-to-edit structure.

---

## TASK-009 — Audio and Polish

- Basic flap sound
- score sound
- collision / death sound
- basic visual polish
- tune gameplay feel

---

## TASK-010 — Final V1 QA

Check:

- gameplay
- scoring
- high score
- restart
- random backgrounds
- death reasons
- death reactions
- quotes
- audio
- different window sizes
- obvious errors or regressions

V2 begins only after V1 is accepted.