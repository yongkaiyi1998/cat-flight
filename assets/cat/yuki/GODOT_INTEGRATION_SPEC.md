Cat Flight — Yuki V1 Pixel Player Asset

FRAME SIZE
128 x 128 px

SPRITE SHEET
768 x 128 px
1 row x 6 columns

FRAME ORDER (left -> right)
0 FLY_01
1 FLY_02
2 FLY_03
3 HIT
4 BONK
5 SQUASH

FLY ANIMATION
Recommended 7 FPS for passive 01 -> 02 -> 03 -> 02 loop.
For tap/flap response, switch/snaps to FLY_03, then return toward FLY_02 / FLY_01.

PIVOT / ANCHOR
Use Sprite2D centered = true.
Use frame center (64,64) as the import/display pivot.
Keep the Player/CollisionShape2D node independent from Sprite2D visual tweening when possible.

COLLISION
Recommended starting shape: horizontal CapsuleShape2D or rounded RectangleShape2D.
Suggested starting visible/core hitbox in the 480x720 logical viewport: about 42-46 px wide x 26-30 px high.
Center it over head + torso core, slightly forward of the visual midpoint if needed.
Exclude tail tip, ear tips, whiskers, and far paw tips.
After first in-game test, tune against the actual obstacle gap before freezing.

TEXTURE / PIXEL SETTINGS
Godot texture filtering: Nearest / Disabled filtering.
Do not use linear filtering.
Keep mipmaps off for this 2D sprite.
Avoid non-integer per-sprite scaling if practical; the art is sized to be usable near 1:1 in the 480x720 logical viewport.
If project-wide filtering is set elsewhere, override this texture/import to nearest.

FILES
cat_yuki_sprite_sheet_6x1_128.png
cat_yuki_fly_01.png
cat_yuki_fly_02.png
cat_yuki_fly_03.png
cat_yuki_hit.png
cat_yuki_bonk.png
cat_yuki_squash.png
