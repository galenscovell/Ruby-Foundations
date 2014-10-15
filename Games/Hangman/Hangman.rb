
# Hangman game with emphasis on OOP!
# Includes imported dictionary for word selection and progress saving/loading


class Player
  attr_accessor :wins, :losses, :name

  def initialize(name)
    @wins = 0
    @losses = 0
    @name = name
  end
end



class Hangman
  attr_accessor :turns, :used
  attr_reader :word

  def initialize
    @turns = 1
    @used = []
    
    word_list = File.open('dictionary.txt', 'r') do |file| 
      file.read
    end
    valid_words = word_list.split.select do |word|
      word.length.between?(5, 12)
    end
    @word = valid_words[rand(valid_words.size)].downcase

    @board = ("-" * @word.length)
    @letters_remaining = @word.length
  end

  def show(player)
    puts "\n\tPlayer: #{player.name}"
    puts "\tWins: #{player.wins}"
    puts "\tLosses: #{player.losses}"
    puts "\tTurn Number: #{@turns}"
    puts "\n\t|" + ("~" * @word.length) + "|"
    puts "\t|" + (" " * @word.length) + "|"
    puts "\t|#{@board}" + "|"
    puts "\t|" + ("_" * @word.length) + "|"
  end

  def guess(player)
    word_duplicate = @word.split("")
    puts "\n[Enter a letter ('word' to guess word, 'save' to save):] "
    letter = gets.chomp.downcase
  
    if letter == "word"
      guess_word
    elsif letter == "save"
      save(player)
    elsif letter.length != 1 || @used.include?(letter)
      guess
    elsif word_duplicate.include?(letter)
      amount = 0
      word_duplicate.each_with_index do |char, idx|
        if char == letter
          @board[idx] = "#{letter}"
          amount += 1
        end
      end
      @letters_remaining -= amount
      @used << letter
      puts "\n\n[Yup, #{letter} is in the word #{amount} times.]"
    else
      @used << letter
      puts "\n\n[Nope, #{letter} is not in the word.]"
    end
  end

  def guess_word
    puts "\n[What's the word?]"
    guessed_word = gets.chomp.downcase
    if guessed_word == @word
      @letters_remaining = 0
      win?
    else
      puts "\n[Nope, that's not it.]"
    end
  end

  def win?
    if @letters_remaining == 0
      true
    else
      false
    end
  end

  def save(player)
    Dir.mkdir("saves") unless Dir.exists?("saves")
    puts "\n[Enter filename for save:]"
    filename = "saves/" + gets.chomp.downcase + ".txt"

    File.open(filename, 'w') do |file|
      file.puts @turns, @used, @word, @letters_remaining, player.wins, player.losses, player.name
    end
  end

  def again?(player)
    again = " "
    until again[0] == "y" || again[0] == "n"
      puts "\n[Play again?]"
      again = gets.chomp.downcase
    end
    if again[0] == "y"
      game_flow(player)
    else
      puts "See you later!"
      puts "\n"
      exit
    end
  end
end



def load_game
  puts "[Enter filename to load:]"
  filename = "saves/" + gets.chomp.downcase + ".txt"

  if File.exists?(filename)
    File.read(filename, 'r') do |file|
      exit
    end
  else
    puts "File does not exist."
  end
end

def game_flow(player)
  game = Hangman.new
  game.show(player)
  until game.turns == 7
    game.turns += 1
    game.guess(player)
    if game.win?
      puts "\n[Word guessed!]"
      player.wins += 1
      game.again?(player)
    end
    game.show(player)
  end
  puts "\n[No more turns!]"
  puts "[Word was #{game.word}. Better luck next time.]"
  puts "\n"
  player.losses += 1
  game.again?(player)
end


puts "\n[+=+=+=+=+{HANGMAN}+=+=+=+=+]"
loading = " "
until loading[0] == "y" || loading[0] == "n"
  puts "\n[Load previous game?]"
  loading = gets.chomp.downcase
end
if loading[0] == "y"
  load_game
else
  puts "\n[Enter player name:]"
  name = gets.chomp
  player = Player.new(name)
  game_flow(player)
end

