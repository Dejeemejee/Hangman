module Includable
  AlPHABETS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
end

class Board
  
 include Includable
  @@file_of_words = 'google-10000-english-no-swears.txt'
  
  attr_accessor :secret_word
  def initialize
    @random_words = []
    @secret_word = []
    @count = 0
    @board = []
    @player = Player.new
  end

  def words_of_five_and_twelve
    File.readlines(@@file_of_words).each do |line|
      line.chomp
      if (line.length > 5) && (line.length < 12)
          @random_words << line.delete!("\n")
      end
    end
    # @random_word
    # @random_word.size
  end

  def select_rand_word
    @secret_word = @random_words.sample
    p @secret_word = @secret_word.split("")
  end

  def display_board
    l = @secret_word.length
    @board = Array.new(l, "_") 
    puts @board
  end

  def update_board
     
  end
  
  def check_codes?
    @player.get_player_guess
    if @secret_word.include?(@player_guess)
      index = @secret_word.each_with_index.select{|c, i| c == @player_guess}.map(&:last)
      index.each do |i|
        @board[i] = @player_guess
      end
    else

    end
  end

end

class Player
  def initialize
    @player_name = gets.chomp
    @player_guess = []
  end
  
  def get_player_guess
    @player_guess = gets.chomp
    @player_guess.downcase!
  end
  
end

class Game
  
end

board = Board.new
board.words_of_five_and_twelve
board.select_rand_word