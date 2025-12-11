# [02: Jetpack Joyride](https://20_games_challenge.gitlab.io/games/jetpack/)

Jetpack Joyride is a side-scrolling endless mobile game from 2011. It only requires a single input button to control the player. The game is fairly complex overall, though the basic premise is very simple. The game came from the same studio that made Fruit Ninja.

The game features a character with a machine-gun jetpack. When holding the input, the player will rise (and destroy everything below!) When the input is released, the character will fall. The character can run on the ground if they reach the bottom of the screen.


## Key Takeaways
 - `lerp`: Linear Interpolation
   - Difference with `move_towards`
     - `move_towards` transition values by step / constant speed
     - `lerp` transition values by percentage / ease in
 - `get_gravity`: uses calculated gravity from project and Area2D gravity overrides
 - [`GPUParticles2D` only collides against `LightOcluder2D`](https://forum.godotengine.org/t/how-to-make-particles2d-collide-with-collisionshape2d-and-tilemap/95813/4?u=johnreybacal)
 - Physics material override for `RigidBody2D`
   - bounce!!!
 - Using `Callable` to bind a parameter
   - Connecting a signal with no argument to a method that has a parameter
      - Used `Callable.bind` to bind the needed argument
 - VisibleOnScreenNotifier2D: pretty straightforward

## TODO
 - ~~UI~~
   - ~~paused~~
   - ~~game over~~
   - ~~score: distance~~
     - ~~high score~~
 - obstacles
   - ~~missile birds~~
     - ~~lock on and warning~~
   - ~~running animal~~
     - ~~replaced with rolling (and bouncing) boulder instead~~
   - thorns (eh)
 - ~~despawn obstacles~~
   - ~~after certain time / after leaving camera~~


## Groups
 - player
 - obstacle

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
   - Bounce on floor
 - Improved control responsiveness
   - Added space to `02_jetpack_joyride_click`
 - Added bird (no interaction yet)
### 2025-12-08
 - Die on obstacle
   - die animation (falling / landed)
 - Rename collision layers
   - 1: default
   - 2: floor
 - Set player's `platform_floor_layers` to `floor`
   - this avoids added velocity from hitting obstacle from above
 - Add lock on warning
   - Follow player
   - Spawn bird after warning
 - Added game over trigger
   - Disable all obstacles on game over
 - Gradually increase player speed
 - Record distance traveled on death
 - Improved warning
   - spawn near player, clamped to game area
   - 75% opaque
   - when imminent:
     - remove collision mask/layer
     - fully opaque
     - higher Z index
 - Adjust player movement
 - Add more leaf particle
### 2025-12-09
 - Added rolling boulder that bounces when spawned at height
   - Used flappy bird sprite temporarily, can't find boulder sprite
 - Reorganized collision layers/masks so that bird and boulders won't hit each other
 - On death, player will only scan for floor
   - removed setting of layer and mask of obstacles to 0
     - Boulder relies on floor
### 2025-12-10
 - Adjustments on obstacles
 - Cleanup obstacle when leaving screen
   - Attached to obstacle on spawn instead of adding `VisibleOnScreenNotifier2D` for each obstacle, Bird doesn't even have a script
### 2025-12-11
 - Add UI: game over, pause, score, high score, restart, quit
   - reused HUD scene and script from breakout
   - custom font

## Credits
 - Jungle Pack: https://jesse-m.itch.io/jungle-pack
 - Bird: https://ankousse26.itch.io/bird-flying-pixel-art-animation-free
 - Warning Sign by PixyFantasyStudios: https://pixyfantasystudios.itch.io/warning-sign
 - peaberry-pixel-font: https://emhuo.itch.io/peaberry-pixel-font