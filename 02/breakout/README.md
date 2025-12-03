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

## TODO:
 - Lose ball trigger
   - respawn ball
 - SFX
 - UI
   - Score
   - Life points
 - Aim ball before firing
   - set paddle to middle
 - Brick generation transition
 - Brick break particle?


## Development Log
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


## Credits
 - Bounce ball: https://forum.godotengine.org/t/how-to-bounce-a-ball-with-a-character-correctly-which-nodes-to-use/1400/2?u=johnreybacal
 - Color palette: https://coolors.co/be7c4d-92140c-353238-be5a38-c1b4ae
