# ♟️ Chess ♟️

Console chess game written in Ruby. Made for the [Ruby Final Project](https://www.theodinproject.com/lessons/ruby-ruby-final-project) from [The Odin Project](https://www.theodinproject.com/).

--- 

## My Experience

This certainly is the hardest project I ever made at the day I writing this. I used all my skills I learned so far in this project, and unfortunely I coudn't figured out how to implement the special moves, due to how the code get messy in some parts (especially the way that coordinate works). I had to refactor my code many times, so my mistake here probably has bad code planning. But happily I could make it functional, with almost all the chess mechanics. I writed some tests for the piece movements, but I feel like I need to study more about Tests. 


## Tutorial

Note: This won't teach you how to play chess, but how to run and interact with the game. If you dont know how to play chess, take a look at [this video](https://www.youtube.com/watch?v=OCSbzArwB10).

### Run the game

#### Requirements

- Ruby version: 3.1.2
- gem 'colorize'
- gem 'rspec'

#### After downloading the repo:

1. Open your terminal in the project folder
2. Run 'bundle' to install the required gems
3. Run 'ruby lib/main.rb' to launch the game

### How to Play

When prompted to perfom an action, you have three options:

- Move: To move a piece in game, you must type 'mv (piece position) (target tile)', switching the parenthesis arguments to notation coordinates.  
Example: 'mv a2 a4' will try to move the piece at a2 to the a4 tile. Be sure that the movement is valid!
- Saving the game: Type 'save'
- Exiting the game: Type 'exit' (Note that this wont save the game!)
