# Hangman Game

## Description
Hangman is a classic word guessing game where a player attempts to guess a hidden word by suggesting letters one at a time. This command-line implementation provides an engaging experience with features like game state saving and loading.

## How to Play
1. When you start the game, you'll be prompted to enter your name
2. You can either load a previously saved game or start a new one
3. For a new game:
   - A random word between 5-12 letters will be selected
   - The word is displayed as underscores (_) representing each letter
   - You have 8 attempts to guess the word correctly
4. On each turn:
   - You can enter a single letter as your guess
   - If the letter is in the word, it will be revealed in its correct position(s)
   - If the letter is not in the word, you lose one attempt
   - The game shows you which letters you've already used
5. The game ends when either:
   - You successfully guess the entire word (Win!)
   - You run out of attempts (Game Over)

## Features
- Random word selection from a curated dictionary
- Visual display of game progress
- Letter tracking to show which letters have been used
- Game state saving/loading functionality
- Player name customization
- Input validation to ensure proper gameplay

## Save/Load Feature
- At any point during the game, type 'save' to save your current progress
- You can name your saved game for easy identification
- When starting the game, you can choose to load any previously saved game

## Technical Details
- Written in Ruby
- Uses YAML for game state serialization
- Implements object-oriented programming principles
- Includes error handling for file operations and user input
- Uses a dictionary of English words (non-profane)

## Requirements
- Ruby installed on your system
- Access to command line interface
- Read/Write permissions for save game functionality

## Installation
1. Clone the repository
2. Ensure you have Ruby installed
3. Navigate to the game directory
4. Run `ruby hangman.rb` to start the game

## File Structure
- `hangman.rb`: Main game file
- `google-10000-english-no-swears.txt`: Word dictionary
- `saved_games/`: Directory for saved game files