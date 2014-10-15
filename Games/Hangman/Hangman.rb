
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

  def show(human)
    puts "\n\tPlayer: #{human.name}"
    puts "\tWins: #{human.wins}"
    puts "\tLosses: #{human.losses}"
    puts "\tTurn Number: #{@turns}"
    puts "\n\t|" + ("~" * @word.length) + "|"
    puts "\t|" + (" " * @word.length) + "|"
    puts "\t|#{@board}" + "|"
    puts "\t|" + ("_" * @word.length) + "|"
  end

  def guess
    word_duplicate = @word.split("")
    puts "\n[Enter a letter ('word' to guess word, 'save' to save):] "
    letter = gets.chomp.downcase
  
    if letter == "word"
      guess_word
    elsif letter == "save"
      save
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

  def save
  end

  def load
  end

  def again?
  end
end

puts "\n[+=+=+=+=+{HANGMAN}+=+=+=+=+]"
puts "\n[Enter player name:]"
name = gets.chomp
human = Player.new(name)

# Main game loop
game = Hangman.new
game.show(human)
puts game.word
until game.turns == 7
  game.turns += 1
  game.guess
  if game.win?
    puts "\n[Word guessed!]"
    human.wins += 1
    game.again?
  end
  game.show(human)
end
puts "\n[No more turns!]"
puts "[Word was #{game.word}. Better luck next time.]"
human.losses += 1
game.again?
