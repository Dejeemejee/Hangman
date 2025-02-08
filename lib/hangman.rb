require 'yaml'
require_relative 'board_class.rb'

module Includable
  AlPHABETS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  @@count = 8
end

class Player
 
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

class Game
  
  include Includable

  def initialize
    puts "Welcome to Hangman. Lets have your name!!!!"
    name = gets.chomp
    @player = Player.new(name)
    @g_board = Board.new
  end
   
   
  def announce_winner
    if (@g_board.compare_codes)
     puts "Congratulations #{@player.name}!!! You actually guessed it right"
    else
     puts "Sorry #{@player.name} Try again"
    end
  end
  
  def game_loop
    until @@count == 0 || @g_board.compare_codes do   
      @g_board.check_codes?
      puts "You have #{@@count} out of 8 counts left"
    end
    announce_winner()
  end

  def game_play
    Dir.mkdir("saved_games") unless Dir.exist?("saved_games")
    puts "Enter 1 to load a saved game or 2 to start a new game"
    answer = gets.chomp.strip.to_i
    if answer == 1
      @g_board.deserialize
      game_loop()
    else
      @g_board.words_of_five_and_twelve
      @g_board.select_rand_word
      @g_board.create_board
      @g_board.display_board
      game_loop()
    end
  end

end

game = Game.new
game.game_play

