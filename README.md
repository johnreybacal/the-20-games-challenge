# [The 20 games challenge](https://20_games_challenge.gitlab.io/)

Learning game development with Godot with the 20 games challenge instead of plunging into tutorial hell

I will do all games and log what I learned in a README file for each game
 - each game should have a Key Takeaways and Development Log headers

## Games
 - [01: Pong](01/pong/README.md)
 - [01: Flappy Bird](01/flappy_bird/README.md)
 - [02: Breakout](02/breakout/README.md)
 - [02: Jetpack Joyride](02/jetpack_joyride/README.md)
 - 03: Space Invaders
 - 03: Frogger
 - 03: River Raid
 - ...

 
## Development Constraints
 - Google search as primary source of information (as it was)
 - Disable copilot's next edit suggestion
 - Only use AI to ask about mathematics/physics stuff used in game dev


## TODO
 - ~~Create menu to access all games~~
   - ~~01 Pong: vs CPU / vs Human option~~
 - ~~Deploy to itch.io~~


## Key Takeaways
These items are applicable on development of main menu. More entries in README.md for each game's subfolder
 - Inspection of Nodes while the game is running via Scene > Remote
   - usage of `get_tree()`
 - [Changing scenes manually](https://docs.godotengine.org/en/latest/tutorials/scripting/change_scenes_manually.html)
 - Autoloading scripts
   - usage of global variables and functions

## Development Log
These items are applicable on development of main menu. More entries in README.md for each game's subfolder
### 2025-11-28
 - Implemented main menu
   - Stop process and set invisible when playing games
 - Add global script
   - pass information between scenes
   - reusable functions
 - Set viewport size to 1280x720
   - Set stretch mode to `canvas_items`
### 2025-12-02
 - Add flappy bird game
 - Use `get_tree().change_scene_to_file` when changing scene
   - no longer manage pause and visibility for mainmenu
 - Persist main menu state (session only)
### 2025-12-05
 - Added breakout game
### 2025-12-11
 - Added jetpack joyride game