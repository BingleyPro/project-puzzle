# Project Puzzle

Project Puzzle is a Godot game where you solve puzzles in various environments! Use logical thinking to get through various challenges. Work in progress!

## Installation

Go to Releases on the side and download the version for your device! There are builds for both Mac and Windows (if there are no releases, they will be out today).

## Puzzles

There are currently four levels. The puzzles should be pretty simple, but solutions are below if you get stuck.

<details>
<summary>Level 1</summary>
Flick the lever next to the door to open it. Pick up the crate and place it on the pressure plate next to it to open the door. Before you leave the room, there is a lever in the back corner to open the third door. Exit the room at go through the open door on the right. Make it to the end without falling off, and flick the lever. Return to the corridor and go into the now opened door. Jump across the gap, and you should see the level complete screen.
</details>

<details>
<summary>Level 2</summary>
Place the crate on the pressure place. Go through the door, and flick the lever in the next room. Head back, take the crate off, and the door will stay open. Take the crate to the second room and place it on the plate. Go through the door. Take the crate from the plce its on, and place it on the single plate next to the door. Take the crate from inside that room, then place both crates on the places nearest to the other door. Go through the door, and you should see level complete.
</details>

<details>
<summary>Level 3</summary>
The first puzzle requires you to light the brazier in order. If you look quickly, you will see a crate fall next to each outisde of the iron bars in the right order. The order is:

1. The one next to the door
2. The one to the right of the door
3. The one of the left of the door

Going through the open door takes you to another, bigger one. The crates in the middle tell you the order, with brazier 1 being the one you first see right in front of you, and the others being counted clockwise. The order is 2, 5, 1, 3, 7, 6, 4. Then, go through the opened foor and you should see the level complete screen.
</details>

<details>
<summary>Level 4</summary>
Level4 has a few trickier puzzles. When you start, place a crate on the plate next to the door with the smallest firepit. Take the second crate from the main courtyard and place it on the plate in that room. Then head through the door to the third room, flick the lever, and take the cube from room 2 and place it on that plate. Head back to the main courtyard. You can now enter the room with the middle-sized firepit. use the two crates to make a staircase to be able to reach the lever on the wall above you. Once it's flicked, head to the final room. There is another crate on the far side of this room, and use that along with the other two to open the door and flick the lever. Then, head back to the main area. All three doors to the exit should now be opened, and you ca head all the way through.

Note that there are still some bugs with this puzzle if you encounter issues. Please report them via GitHub if you can!
</details>

## Roadmap

This game currently features four whole puzzles. Some extra mechanics (timer buttons, parkour features etc.) may be added in future, along with more puzzles so look out for now.

The main priority will be current bug/issues, as well as making better modular components so puzzles are quicker to make, have less bugs, and require less extra scripts for levels.

## Known issues

Some of the known issues are listed below:

- Crates are immovable when the player pushes them. They only move when picked up using the interact key.
- Level 4 has a few issues like 
- Doors don't use snapping, and may not be completely aligned