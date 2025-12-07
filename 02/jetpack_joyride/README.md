# [02: Jetpack Joyride](https://20_games_challenge.gitlab.io/games/jetpack/)

Jetpack Joyride is a side-scrolling endless mobile game from 2011. It only requires a single input button to control the player. The game is fairly complex overall, though the basic premise is very simple. The game came from the same studio that made Fruit Ninja.

The game features a character with a machine-gun jetpack. When holding the input, the player will rise (and destroy everything below!) When the input is released, the character will fall. The character can run on the ground if they reach the bottom of the screen.


## Key Takeaways
 - `lerp`: Linear Interpolation
   - Difference with `move_towards`
     - `move_towards` transition values by step / constant speed
     - `lerp` transition values by percentage / ease in
 - `get_gravity`: uses calculated gravity from project and Area2D gravity overrides


## Mapped Actions
 - 02_jetpack_joyride_click


## Development Log
### 2025-12-06
 - Setup game
 - Basic player movement
   - Falling and thrusting upward
 - Move player forward endlessly
 - Temporary parallax background (reused flappy bird assets)
 - Camera follow
   - Put camera as child of player
   - Set camera limits for top and bottom as to be limited from following player's Y position changes
### 2025-12-07
 - Use `get_gravity` instead of scripting it
 - Added Jungle Pack assets
   - Player: running, flying, jumping animation
   - 5 Layer parallax background
   - Floor
 - Added thrust particles
 - Improved control responsiveness
   - Added space to `02_jetpack_joyride_click`


## Credits
 - Jungle Pack: https://jesse-m.itch.io/jungle-pack