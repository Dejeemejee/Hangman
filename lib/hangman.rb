module Includable
  AlPHABETS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  @@count = 8
end

class Board
  
 include Includable
  @@file_of_words = 'google-10000-english-no-swears.txt'
  
  #puts AlPHABETS
  attr_accessor :secret_word, :random_words, :board, :player_code
  def initialize
    @random_words = []
    @secret_word = []
    @board = []
    @player_code = ""
  end

  def words_of_five_and_twelve
    File.readlines(@@file_of_words).each do |line|
      line.chomp
      if (line.length > 5) && (line.length < 12)
          @random_words << line.delete!("\n")
      end
    end
  end

  def select_rand_word
    @secret_word = @random_words.sample
    @secret_word = @secret_word.split("")
    p @secret_word
  end

  def create_board
    ln = @secret_word.length
    @board = Array.new(ln, "_") 
  end

  def display_board
    p AlPHABETS 
    p @board
  end
  
  def check_codes?
    puts "What's your guess?"
    @player_code = gets.chomp
    if @secret_word.include?@player_code
      @@count = @@count
      index = @secret_word.each_with_index.select{|c, i| c == @player_code}.map(&:last)
      index.each do |i|
        @board[i] = @player_code
        update_alphabet_list()
      end
    else
      @@count -= 1
      puts "Incorrect Guess"
    end
    puts "\n"
    display_board
  end

  def update_alphabet_list
    AlPHABETS.map!{|x| x == @player_code ? "#" : x}
  end

  def compare_codes
    @secret_word == @board ? true : false
  end
  
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
   
  puts 
  def announce_winner
    if (@g_board.compare_codes)
     puts "Congratulations #{@player.name}!!! You actually guessed it right"
    else
     puts "Sorry #{@player.name} Try again"
     #puts @player.name.ancestors
    end
  end
  
  def game_play
    puts "Do you want to load a saved game? (yes/no)"
    answer = gets.chomp
    case answer.downcase!
    when "yes" || "Y" || "y"
      Game.load_game
    when "no" || "n" || "n"
        @g_board.words_of_five_and_twelve
        @g_board.select_rand_word
        @g_board.create_board
        @g_board.display_board
        until @@count == 0 || @g_board.compare_codes do   
          @g_board.check_codes?
          puts "You have #{@@count} out of 8 counts left"
        end
        announce_winner()
    else 
        puts "Incorrect input"
    end
  end
  
end

game = Game.new
game.game_play
#board.words_of_five_and_twelve
#board.select_rand_word
#board.check_codes?