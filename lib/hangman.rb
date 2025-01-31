puts "HIIII"

module Includable
  AlPHABETS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
end

class Board
  
 include Includable
  @@file_of_words = 'google-10000-english-no-swears.txt'
  
  #puts AlPHABETS
  attr_accessor :secret_word, :random_words, :board, :player_code
  def initialize
    @random_words = []
    @secret_word = []
    @count = 0
    @board = []
    @player = Player.new
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
    p @board
    p AlPHABETS 
  end
  
  def check_codes?
    @player_code = gets.chomp
    if @secret_word.include?@player_code
      p @player_code.class
      index = @secret_word.each_with_index.select{|c, i| c == @player_code}.map(&:last)
      index.each do |i|
        @board[i] = @player_code
        update_alphabet_list()
      end
    else
       puts "Incorrect Guess"
    end
    display_board
  end

  def update_alphabet_list
    AlPHABETS.map!{|x| x == @player_code ? "#" : x}
  end

end

class Player

  attr_accessor :player_guess
  def initialize
    puts "Let's have your name!"
    @player_name = gets.chomp
    @player_guess = "a"
  end
  
  def get_player_guess
    @player_guess = gets.chomp
    @player_guess.downcase!
  end
  
end

board = Board.new


board.words_of_five_and_twelve
board.select_rand_word
board.create_board
board.display_board
board.check_codes?