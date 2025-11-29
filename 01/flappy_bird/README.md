# [01: Flappy Bird](https://20_games_challenge.gitlab.io/games/flappy/)

Flappy bird was a mobile game from 2013. It was a sleeper hit, gaining sudden and massive popularity in 2014, likely due to attention from a popular YouTuber at that time. The game was removed from the App store after it’s sudden popularity due to negative media attention.

## Dev Note
I already created a flappy bird before by following a tutorial

## Key Takeaways
 - Usage of `position` and `global_position`
   - `position`: relative (to parent)
   - `global_position`: absolute
 - Physics
   - application of force vs impulse
      - force: used for continuous acceleration
      - impulse: used for instant acceleration
 - Rotation: Godot uses radians. PI = 180°, PI/2 = 90° etc...
   - `deg_to_rad`: Converts degrees to radians


## TODO:
 - game over on hit (pipe / floor)
 - UI
   - start
   - score
   - game over
 - Sounds
 - BG parallax
 - high score
   - ghost?
      - save generated pipe Y position, generate on unreached pipes
      - save input to recreate movement for ghost

## Groups
 - player

## Mapped Actions
 - 01_flappy_bird_flap

## Development Log
### 2025-11-29
 - Added Bird
   - Movement and rotation
   - Animation
 - Added PipeObstacle
   - Setup body entered functions for game over and score
 - Added GameManager to spawn PipeObstacle at fixed X and ranged Y coordinates at an interval

## Credits

- Assets: https://kosresetr55.itch.io/flappy-bird-assets-by-kosresetr55