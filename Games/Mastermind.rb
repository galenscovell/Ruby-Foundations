
# Mastermind game with focus on OOP

class Player
  attr_accessor :wins, :losses

  def initialize
    @wins = 0
    @losses = 0
  end
end

class Mastermind
  attr_accessor :board, :guess, :hints, :turns

  def initialize
    @board = {1 => " ", 2 => " ", 3 => " ", 4 => " "}
    @guess = {1 => " ", 2 => " ", 3 => " ", 4 => " "}
    @hints = {1 => " ", 2 => " ", 3 => " ", 4 => " "}
    @turns = 6
  end

  def draw
    puts "\nGuesses remaining: #{@turns}"
    puts "\nGuess :| [#{@guess[1]}] [#{@guess[2]}] [#{@guess[3]}] [#{@guess[4]}] |"
    puts " Hint :| [#{@hints[1]}] [#{@hints[2]}] [#{@hints[3]}] [#{@hints[4]}] |"
  end

  def game_over_code
    puts "\nCode was: | [#{@board[1]}] [#{@board[2]}] [#{@board[3]}] [#{@board[4]}] |"
  end

  def check_win(guess)
    if @board == @guess
      true
    else
      false
    end
  end

  def computer_hint(guess)
    hint_array = []
    board_duplicate = {1 => @board[1], 2 => @board[2], 3 => @board[3], 4 => @board[4]}
    guess_duplicate = {1 => guess[1], 2 => guess[2], 3 => guess[3], 4 => guess[4]}
    guess_duplicate.each do |k, v|
      if v == board_duplicate[k]
        hint_array << "X"
        board_duplicate.delete(k)
        guess_duplicate.delete(k)
      end
    end
      
    guess_duplicate.each do |k, v|
      if board_duplicate.has_value?(v)
        hint_array << "W"
        board_duplicate.delete(v)
        guess_duplicate.delete(k)
      end
    end
    while hint_array.size < 4
      hint_array << " "
    end
    # hint_array.shuffle!
    @hints.update(@hints) { |k, v| v = hint_array[k-1] }
  end

  def player_guess
    guess_arr = []
    until guess_arr.size == 4
      puts "\nEnter 4 digit code using R G B Y (separated by spaces): "
      guess_arr = gets.chomp.split
      guess_arr.each { |n| n =~ /[0-9]/ ? guess_arr.delete(n) : n.upcase! }
      guess_arr.keep_if { |v| v =~ /[RGBY]/ }
    end
    @guess.update(@guess) { |k, v| v = guess_arr[k-1] }
    @guess
  end

  def computer_make_code
    colors = ["R", "G", "B", "Y"]
    @board.each do |key, value|
      @board[key] = colors.sample
    end
    puts "\nCode created."
    @board
  end
end

def menu(player)
  puts "\n[-------MASTERMIND-------]"
  puts "|1. Play as Codemaker    |"
  puts "|2. Play as Codebreaker  |"
  puts "|3. How to Play          |"
  puts "|4. Quit                 |"
  puts "[------------------------]"
  selection = 0
  until selection.between?(1, 4)
    puts "Enter selection: "
    selection = gets.chomp.to_i
    if selection == 1
      codemaker(player)
    elsif selection == 2
      codebreaker(player)
    elsif selection == 3
      how_to_play(player)
    end
  end
end

def codemaker(player)
  board = Mastermind.new
  board.draw
  code_hash = board.player_make_code
end

def codebreaker(player)
  board = Mastermind.new
  board.draw
  code = board.computer_make_code
  while board.turns > 0
    guessed_code = board.player_guess
    if board.check_win(guessed_code)
      puts "\nCode correctly broken. Player wins!"
      player.wins += 1
      play_again(player)
    else
      hint = board.computer_hint(guessed_code)
      board.draw
      board.turns -= 1
    end
  end
  puts "\nNo guesses remaining. Computer wins!"
  player.losses += 1
  board.game_over_code
  play_again(player)
end

def how_to_play(player)
  puts "\nAs codemaker, you create a 4 digit code using colors (R Y G B)."
  puts "The computer attempts to guess this code."
  puts "You supply hints for the computer using 4 hint spots."
  puts "If the guess matches a color present in the code, but in the wrong spot, "
  puts "add a W(hite) digit (one for each color matched but in wrong spot)."
  puts "If the color is in the correct spot, add an X."
  puts "The hints are not placed in order."
  puts "If the computer guesses the code correctly in 6 turns, they win."

  puts "\nAs code breaker, the above game is played but reversed "
  puts "as the computer builds a code and you attempt to guess it."
  menu(player)
end

def play_again(player)
  puts "\nPlayer wins: #{player.wins}."
  puts "Computer wins: #{player.losses}."
  puts "\nPlay again?"
  again = gets.chomp.upcase
  if again[0] == "Y"
    menu(player)
  else
    exit
  end
end

human_player = Player.new
menu(human_player)