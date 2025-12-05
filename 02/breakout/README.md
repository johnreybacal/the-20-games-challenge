# [02: Breakout](https://20_games_challenge.gitlab.io/games/breakout/)

Atari’s first successful game (Pong) was massively successful, but many companies made clones of the game, which eroded Atari’s profits. Their response was to make new and innovative games in order to stay ahead of the competition. Breakout was a direct descendent of Pong, but was designed for one player instead of two. It came out in 1976.


## Key Takeaways
 - Getting mouse position
   - absolute: get_viewport().get_mouse_position()
   - relative to origin: get_global_mouse_position()
 - `PhysicsBody2D`'s `move_and_collide`: https://docs.godotengine.org/en/stable/classes/class_physicsbody2d.html#class-physicsbody2d-method-move-and-collide
   - returns a [KinematicCollision2D](https://docs.godotengine.org/en/stable/classes/class_physicsbody2d.html#class-physicsbody2d-method-move-and-collide)
     - contains information about:
       - Collider object
       - Normal: colliding body's shape's normal at the point of collision
         - a vector that points perpendicularly away from the surface at the point of collision
         - the direction the surface is facing at the hit point
 - `Vector2`'s `bounce`
   - Returns the vector "bounced off" from a line defined by the given normal n perpendicular to the line.
 - [Difference between _process() and _physics_process()](https://forum.godotengine.org/t/difference-between-process-and-physics-process/4726)
 - `Vector2`'s `direction_to`
 - `Node`'s [`_input`](https://docs.godotengine.org/en/stable/classes/class_node.html#class-node-private-method-input) hook


## TODO:
 - ~~Lose ball trigger~~
   - ~~respawn ball~~
 - ~~SFX~~
 - ~~UI~~
   - ~~Score~~
   - ~~Life points~~
 - ~~Aim ball before firing~~
   - ~~set paddle to middle~~
 - Brick generation transition
 - Brick break particle?
 - Fix ball displacing paddle on impact
   - Don't know why it happens
     - played around with weights (light ball, heavy paddle)
     - converted Paddle into `CharacterBody2D` as ["They are not affected by physics at all"](https://docs.godotengine.org/en/stable/classes/class_characterbody2d.html#:~:text=They%20are%20not%20affected%20by%20physics%20at%20all)
   - Turned this into paddle recoiling from the ball instead
     - not a bug
       - a feature
         - and a cool one at that
 - ~~Read https://docs.godotengine.org/en/stable/tutorials/math/vector_math.html~~

## Groups
 - paddle
 - ball
 - floor

## Mapped Actions
 - 02_breakout_click


## Development Log
### 2025-12-03
 - Added paddle
   - follow mouse
   - reuse Pong AI slow down logic
 - Added ball
   - bounce off other bodies
     - maintain speed
   - destroy bricks on collision
 - Added BG
 - Added walls
 - Added Brick
 - Added Game manager
   - generate Bricks on _ready
### 2025-12-04
 - Move paddle to middle if not in play
 - Spawn ball on start and on losing ball
 - Play ball on mouse left
   - Set initial direction towards mouse
     - Fixed ball bounce velocity calculation
 - Fix ball bouncing back and forth in a single line
 - Push paddle downward and return when hitting ball
 - Updated paddle movement
 - Use `_input` callback instead of `_process` for listening for input
### 2025-12-05
 - Reused SFX from other games
 - Increase ball speed on every brick hit
 - Only push down paddle when ball hit from above
 - Added UI
   - Life
   - Score
   - High score
   - Pause
   - Game over

## Credits
 - Bounce ball: https://forum.godotengine.org/t/how-to-bounce-a-ball-with-a-character-correctly-which-nodes-to-use/1400/2?u=johnreybacal
 - Color palette: https://coolors.co/be7c4d-92140c-353238-be5a38-c1b4ae
