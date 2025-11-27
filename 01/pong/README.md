# [01: Pong](https://20_games_challenge.gitlab.io/games/pong/)

Pong was the first widely successful arcade game. It was released in 1972, and started the first arcade boom. The game may seem simple today, but it was designed directly in hardware. Essentially, Pong was a specialized computer designed to bounce a ball between two paddles and keep score.


## Key takeaways
 - Connecting signals
 - Usage of enum for state
 - Using `GradientTexture2D` in `Sprite2D` to draw rectangle and circle instead of using images
 - Moving nodes using `global_position`
 - `RigidBody2D` can't detect `Area2D`
 - `call_deferred` schedules a function call after the current frame
   - execution came from `_on_area_exited` of PlayArea
      - Scene tree is locked
   - `spawn_ball` has `add_child` which tries to modify the scene tree while locked
 - Normalizing vector length with `normalize`
 
    | Input Vector2 | Length Before | Normalized Output | Length After           |
    |---------------|---------------|-------------------|------------------------|
    | (1, 1)        | 1.4142        | (0.7071, 0.7071)  | 1.0                    |
    | (2, 0)        | 2.0           | (1.0, 0.0)        | 1.0                    |
    | (0, -3)       | 3.0           | (0.0, -1.0)       | 1.0                    |
    | (-4, 3)       | 5.0           | (-0.8, 0.6)       | 1.0                    |
    | (0.2, 0.6)    | 0.6325        | (0.3162, 0.9487)  | 1.0                    |
    | (0, 0)        | 0.0           | (0, 0)            | 0.0 (cannot normalize) |

    Vector length affects how fast an object moves diagonally, which caused inconsistent ball speed
 - [Process Modes](https://docs.godotengine.org/en/latest/tutorials/scripting/pausing_games.html#process-modes)
   - Always: applied to Game Manager
   - Pausable: applied to Ball
 - The ball's `queue_free` triggers the play area's `_on_area_exited`
 - A `Container` must have a script attached to control control nodes inside it
 - Use of `move_toward` to smoothen transition between 2 values using `delta`


## TODO:
 - ~~Single player (P2 is AI)~~
 - ~~Pause menu~~
   - ~~Resume~~
   - ~~Reset~~
 - ~~Confetti particles on score~~
   - ~~Sound effects~~

## Groups
 - paddle
 - wall
 - ball

## Mapped Actions
 - 01_pong_p1_up
 - 01_pong_p1_down
 - 01_pong_p2_up
 - 01_pong_p2_down
 - 01_pong_space

## Development Log
### 2025-11-26
 - Implemented paddle movement `global_position` and axis between two actions
   - movement bounded by walls
 - Implemented ball movement
   - bounce against walls
   - bounce against paddles with randomness
 - Added ball hit sound
 - Implemented PlayArea
   - Score if ball exited it
   - Get score winner by comparing against `global_position.x` of ball
 - Added Game manager to orchestrate everything
 - Added HUD
    - P1 and P2 score tracking
    - Rally score tracking
    - Start label
### 2025-11-27
 - Fixed inconsistent ball speed with normalization
 - Implement pause and reset
 - Remapped `01_pong_fire` to `01_pong_space` as it is also used to pause/unpause
 - Mapped `01_pong_reset` to reset the game
 - Implement AI for P2 to follow ball
   - only set axis to move towards to reuse Paddle's `_process` and boundedness
 - Added confetti on score. 

## Credits

- Tennis ball hit sound: Sound Effect by <a href="https://pixabay.com/users/dragon-studio-38165424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=386155">DRAGON-STUDIO</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=386155">Pixabay</a>
- Score sound: Sound Effect by <a href="https://pixabay.com/users/floraphonic-38928062/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=224403">floraphonic</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=224403">Pixabay</a>
- Confetti particle setup guide: https://gist.github.com/benmccown/52eb2d9b0a2899fe4d6d6aea6514eafb