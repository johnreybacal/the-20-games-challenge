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

## TODO:
 - Single player (P2 is AI)
 - Pause menu
   - Resume
   - Reset
 - Confetti particles on score
   - Sound effects

## Groups
 - paddle
 - wall
 - ball

## Mapped Actions
 - 01_pong_p1_up
 - 01_pong_p1_down
 - 01_pong_p2_up
 - 01_pong_p2_down
 - 01_pong_fire

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

## Credits

- Tennis ball hit sound: Sound Effect by <a href="https://pixabay.com/users/dragon-studio-38165424/?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=386155">DRAGON-STUDIO</a> from <a href="https://pixabay.com/sound-effects//?utm_source=link-attribution&utm_medium=referral&utm_campaign=music&utm_content=386155">Pixabay</a>