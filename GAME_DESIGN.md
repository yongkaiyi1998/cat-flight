# Cat Flight — Game Design

## Goal

Create a small, polished mobile-friendly Flappy-like game as the first Godot project.

Target:
- Playable quickly
- Simple codebase
- Easy to understand and modify
- V1 completed within about 15 hours

## Core Gameplay

- The player controls a flying cat.
- Click / tap / Space makes the cat flap upward.
- Gravity continuously pulls the cat downward.
- The world moves from right to left.
- The cat flies through gaps between obstacles.
- Passing an obstacle pair gives +1 score.
- Hitting an obstacle, ceiling, or ground ends the run.
- Player can restart quickly.

## V1 Features

- Cat flight controls
- Random obstacle gap positions
- Score
- High score
- Fast restart
- Random background per run
- 3 different death reactions
- Random funny death quote
- Basic sound effects
- Desktop controls during development
- Mobile-friendly design

## Death Reactions

Initial target:

1. Wall collision
   - Cat hits the obstacle and falls.

2. Ceiling collision
   - Cat reacts to the impact and falls.

3. Ground collision
   - Cat hits the ground with a simple cartoon reaction.

These may initially use placeholder visuals.

## Backgrounds

Each new run randomly selects a background.

During prototype development, simple colors or placeholder backgrounds are acceptable.

## Death Quotes

After death, show one random short funny quote.

Example tone:

- "That wall came out of nowhere."
- "Gravity wins again."
- "One more try."
- "Definitely a hitbox problem."
- "Meow."

Final quote list can be expanded later.

## Art Direction

V1 starts with placeholder graphics.

Do not spend time on final cat pixel art until the core gameplay is working.

## V2 — Not Part of V1

- Unlockable cat types
- Cat cosmetics
- Cosmetic selection screen
- Unlock progression
- Items / power-ups
- Additional game modes
- Achievements
- Daily challenges
- Online leaderboard
- Ads
- In-app purchases

Do not implement V2 features during V1.