module Includable
  AlPHABETS = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
  @@count = 8
end

class Board
  
  include Includable
   @@file_of_words = 'google-10000-english-no-swears.txt'
   
   #puts AlPHABETS
   attr_accessor :secret_word, :random_words, :board, :player_code, :AlPHABETS
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
     puts "\nEnter a letter to guess (or type 'save' to save the game):"
     input = gets.chomp.strip
     if input.downcase == "save"
       serialize()
     elsif input.match?(/^[a-zA-Z]$/)
       @player_code = input
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
     else
       puts "Invalid input. Please enter a single letter or the word 'save'. Thanks"
     end
   end
 
 
   def update_alphabet_list
     AlPHABETS.map!{|x| x == @player_code ? "#" : x}
   end
 
   def compare_codes
     @secret_word == @board ? true : false
   end
 
   def serialize
     puts "Enter desired name for your file"
     file_name = gets.chomp.strip
     File.open("saved_games/#{file_name}.yaml", "w") do |file|
       game_state = {
         # 'random_words' => @random_words,
         'secret_word' => @secret_word,
         'board' => @board,
         'player_code' => @player_code,
         'count' => @@count
       }
       file.write(YAML.dump(game_state))
       puts "Game successfully saved"
     end
   end
 
   def deserialize
     saved_files = Dir["saved_games/*.yaml"]
     puts saved_files
     if saved_files.empty?
       puts "No saved game"
       return nil
     else 
       puts "Choose the saved game you intend to load: "
       saved_files.each_with_index do |file, index|
         puts "#{index + 1}. #{File.basename(file, ".yaml")}"
       end
       choice = gets.chomp.to_i - 1
       if choice.between?(0, saved_files.length - 1)
         game_data = YAML.load_file(saved_files[choice])
         puts "Game Loaded successfully!"
          @secret_word, @board, @player_code, @@count = game_data["secret_word"], game_data["board"], game_data["player_code"], game_data["count"]
          p @board
          puts "You have #{@@count} out of 8 guesses left"
       else
         puts "Invalid choice. Starting a new game instead"
         return nil
       end
     end
   end
   
 end
 