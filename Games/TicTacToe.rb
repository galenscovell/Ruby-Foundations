
# Tic-tac-toe game designed with emphasis on OOP
# This time without overly complicated multidimensional arrays!

class Board
  attr_accessor :board

  def initialize
    @board = {1 => " ", 2 => " ", 3 => " ", 4 => " ", 5 => " ", 6 => " ", 7 => " ", 8 => " ", 9 => " "}
    @columns = [
      [1, 2, 3], 
      [4, 5, 6], 
      [7, 8, 9],

      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],

      [1, 5, 9],
      [3, 5, 7]
      ] 
  end

  def show
    puts "\n   1[#{@board[1]}] 2[#{@board[2]}] 3[#{@board[3]}]"
    puts "   4[#{@board[4]}] 5[#{@board[5]}] 6[#{@board[6]}]"
    puts "   7[#{@board[7]}] 8[#{@board[8]}] 9[#{@board[9]}]"
  end

  def update(symbol, spot)
    @board[spot] = symbol
  end

  def check_move(player, symbol, spot) 
    if @board[spot] == " "
      update(symbol, spot)
    else
      puts "That spot is already taken."
      player_move(player, symbol)
    end
  end

  def player_move(player, symbol)
    puts "\n#{player}'s turn (#{symbol}'s)."
    choice = 0
    until choice.between?(1, 9)
      puts "Place #{symbol} where?"
      choice = gets.chomp.to_i
    end
    check_move(player, symbol, choice)
  end

  def check_win
    x_win = ["X", "X", "X"]
    o_win = ["O", "O", "O"]
    row_1 = [@board[1], @board[2], @board[3]]
    row_2 = [@board[4], @board[5], @board[6]]
    row_3 = [@board[7], @board[8], @board[9]]
    column_1 = [@board[1], @board[4], @board[7]]
    column_2 = [@board[2], @board[5], @board[8]]
    column_3 = [@board[3], @board[6], @board[9]]
    diagonal_1 = [@board[1], @board[5], @board[9]]
    diagonal_2 = [@board[3], @board[5], @board[7]]

    # Horizontal wins
    if row_1 == x_win || row_1 == o_win
      true
    elsif row_2 == x_win || row_2 == o_win
      true
    elsif row_3 == x_win || row_3 == o_win
      true

    # Vertical wins
    elsif column_1 == x_win || column_1 == o_win
      true
    elsif column_2 == x_win || column_2 == o_win
      true
    elsif column_3 == x_win || column_3 == o_win
      true

    # Diagonal wins
    elsif diagonal_1 == x_win || diagonal_1 == o_win
      true
    elsif diagonal_2 == x_win || diagonal_2 == o_win
      true
    else
      false
    end
  end

  def times_in_column (arr, symbol)
    times = 0
    arr.each do |i|
      times += 1 if @board[i] == symbol
      unless @board[i] == symbol || @board[i] == " "
        return 0
      end
    end
    times
  end

  def empty_in_column (arr)
    arr.each do |i|
      if @board[i] == " "
        return i
      end
    end
  end

  def computer_move
    spot = computer_find_move
    @board[spot] = "O"
  end

  def computer_find_move
    puts "\n Computer's turn (O's)."
    # Take win
    @columns.each do |column|
      if times_in_column(column, "O") == 2
        return empty_in_column(column)
      end
    end
    
    # Block player win
    @columns.each do |column|
      if times_in_column(column, "X") == 2
        return empty_in_column(column)
      end
    end
    
    # Take positions next to adjacent
    @columns.each do |column|
      if times_in_column(column, "O") == 1
        return empty_in_column(column)
      end
    end

    # Center or random
    if @board[5] == " "
      return 5
    else
      open_spots = []
      @board.each do |k, v|
        if v == " "
          open_spots << k.to_i
        end
      end
      random_spot = open_spots.sample
      return random_spot
    end
  end
end


class Player
  attr_reader :name, :symbol
  attr_accessor :wins

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @wins = 0
  end
end


class Computer
  attr_reader :name, :symbol
  attr_accessor :wins

  def initialize
    @name = "Computer"
    @symbol= "O"
    @wins = 0
  end
end

def play_again(player_1, player_2)
  puts "\nPlayer 1 wins: #{player_1.wins}."
  puts "Player 2 wins: #{player_2.wins}."
  puts "\nPlay again?"
  again = gets.chomp.upcase
  if again[0] == "Y"
    game_play(player_1, player_2)
  else
    exit
  end
end

def game_play(first, second)
  board = Board.new
  board.show
  remaining_moves = 9

  until board.check_win
    while remaining_moves > 0
      if first.name == "Computer"
        board.computer_move    
        board.show
        if board.check_win
          puts "#{first.name} wins!"
          first.wins += 1
          play_again(second, first)
        end
        remaining_moves -= 1
        if remaining_moves == 0
          break
        end
      else
        board.player_move(first.name, first.symbol)
        board.show
        if board.check_win
          puts "#{first.name} wins!"
          first.wins += 1
          play_again(second, first)
        end
        remaining_moves -= 1
        if remaining_moves == 0
          break
        end
      end
      if second.name == "Computer"
        board.computer_move
        board.show
        if board.check_win
          puts "#{second.name} wins!"
          second.wins += 1
          play_again(first, second)
        end
        remaining_moves -= 1
      else
        board.player_move(second.name, second.symbol)
        board.show
        if board.check_win
          puts "#{second.name} wins!"
          second.wins += 1
          play_again(first, second)
        end
        remaining_moves -= 1
      end
    end
    puts "No moves left. Draw!"
    break
  end
  play_again(second, first)
end

puts "\nThis is Tic-Tac-Toe, the game of pure skill."

puts "\nPlayer 1 name: "
name_1 = gets.chomp
symbol_1 = "X"
player_1 = Player.new(name_1, symbol_1)

mode = " "
while mode != "computer" && mode != "player"
  puts "Vs. Computer or Vs. Player?"
  mode = gets.chomp.downcase
end
if mode == "player"
  puts "Player 2 name: "
  name_2 = gets.chomp
  symbol_2 = "O"
  player_2 = Player.new(name_2, symbol_2)
  game_play(player_1, player_2)
else
  computer_ai = Computer.new
  game_play(player_1, computer_ai)
end
