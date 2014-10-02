
# Tic-tac-toe game designed with emphasis on OOP

class Player
  attr_reader :name, :symbol
  attr_accessor :wins

  def initialize(name, symbol)
    @name = name
    @symbol= symbol
    @wins = 0
  end
end

class Board

  def initialize
    @board_arr = [["-", "-", "-"], ["-", "-", "-"], ["-", "-", "-"]]
  end

  def show
    puts "\n"
    @board_arr.each do |subarray|
      puts "     | " + subarray.join(" ") + " |"
    end
  end

  def update(symbol, row, column)
    @board_arr[row-1][column-1] = symbol
    $board.show
  end

  def check_win
    x_win = ["X", "X", "X"]
    o_win = ["O", "O", "O"]
    # Check rows
    if [@board_arr[0], @board_arr[1], @board_arr[2]].include?(x_win)
      return true
    elsif [@board_arr[0], @board_arr[1], @board_arr[2]].include?(o_win)
      return true
    end

    # Check columns
    if [@board_arr[0][0], @board_arr[1][0], @board_arr[2][0]] == (x_win)
      return true
    elsif [@board_arr[0][1], @board_arr[1][1], @board_arr[2][1]] == (x_win)
      return true
    elsif [@board_arr[0][2], @board_arr[1][2], @board_arr[2][2]] == (x_win)
      return true
    elsif [@board_arr[0][1], @board_arr[1][1], @board_arr[2][1]] == (o_win)
      return true
    elsif [@board_arr[0][1], @board_arr[1][1], @board_arr[2][1]] == (o_win)
      return true
    elsif [@board_arr[0][1], @board_arr[1][1], @board_arr[2][1]] == (o_win)
      return true
    end

    # Check diagonals
    if [@board_arr[0][0], @board_arr[1][1], @board_arr[2][2]] == (x_win)
      return true
    elsif [@board_arr[0][2], @board_arr[1][1], @board_arr[2][0]] == (x_win)
      return true
    elsif [@board_arr[0][0], @board_arr[1][1], @board_arr[2][2]] == (o_win)
      return true
    elsif [@board_arr[0][2], @board_arr[1][1], @board_arr[2][0]] == (o_win)
      return true
    end
    return false
  end

  def check_move(player, symbol, row, column) 
    if @board_arr[row-1][column-1] == "-"
      update(symbol, row, column)
    else
      puts "That spot is already taken."
      player_move(player, symbol)
    end
  end

  def player_move(player, symbol)
    puts "\n#{player}'s turn (#{symbol}'s)."
    choice = [0, 0]
    until choice[0].between?(1, 3) && choice[1].between?(1, 3)
      puts "Place #{symbol} where? (row column) "
      input = gets.chomp.split(" ")
      choice[0], choice[1] = input[0].to_i, input[1].to_i
    end
    check_move(player, symbol, choice[0], choice[1])
  end

  def computer_move
    puts "\nComputer turn (O's)."
   
    # Take horizontal win
    if @board_arr[0].count("O") == 2 && @board_arr[0].count("-") == 1
      @board_arr[0].map! { |x| x == "-" ? "O" : x }
      $board.show
    elsif @board_arr[1].count("O") == 2 && @board_arr[1].count("-") == 1
      @board_arr[1].map! { |x| x == "-" ? "O" : x }
      $board.show
    elsif @board_arr[2].count("O") == 2 && @board_arr[2].count("-") == 1
      @board_arr[2].map! { |x| x == "-" ? "O" : x }
      $board.show

    # Block player horizontally
    elsif @board_arr[0].count("X") == 2 && @board_arr[0].count("-") == 1
      @board_arr[0].map! { |x| x == "-" ? "O" : x }
      $board.show
    elsif @board_arr[1].count("X") == 2 && @board_arr[1].count("-") == 1
      @board_arr[1].map! { |x| x == "-" ? "O" : x }
      $board.show
    elsif @board_arr[2].count("X") == 2 && @board_arr[2].count("-") == 1
      @board_arr[2].map! { |x| x == "-" ? "O" : x }
      $board.show

    # Center
    elsif @board_arr[1][1] == "-"
      @board_arr[1][1] = "O"
      $board.show

    # Diagonals
    elsif (@board_arr[0][0] == "X" || @board_arr[0][0] == "O") && @board_arr[2][2] == "-"
      @board_arr[2][2] = "O"
      $board.show
    elsif (@board_arr[0][2] == "X" || @board_arr[0][2] == "O") && @board_arr[2][0] == "-"
      @board_arr[2][0] = "O"
      $board.show
    elsif (@board_arr[2][0] == "X" || @board_arr[2][0] == "O") && @board_arr[0][2] == "-"
      @board_arr[0][2] = "O"
      $board.show
    elsif (@board_arr[2][2] == "X" || @board_arr[2][2] == "O") && @board_arr[0][0] == "-"
      @board_arr[0][0] = "O"
      $board.show

    # Adjacent to corner spots
    elsif @board_arr[0][0] == "O" && @board_arr[1][0] == "-"
      @board_arr[1][0] = "O"
      $board.show
    elsif @board_arr[0][0] == "O" && @board_arr[0][1] == "-"
      @board_arr[0][1] = "O"
      $board.show 
    elsif @board_arr[0][2] == "O" && @board_arr[0][1] == "-"
      @board_arr[0][1] = "O"
      $board.show
    elsif @board_arr[0][2] == "O" && @board_arr[1][2] == "-"
      @board_arr[1][2] = "O"
      $board.show
    elsif @board_arr[2][0] == "O" && @board_arr[1][0] == "-"
      @board_arr[1][0] = "O"
      $board.show
    elsif @board_arr[2][0] == "O" && @board_arr[2][1] == "-"
      @board_arr[2][1] = "O"
      $board.show
    elsif @board_arr[2][2] == "O" && @board_arr[1][2] == "-"
      @board_arr[1][2] = "O"
      $board.show
    elsif @board_arr[2][2] == "O" && @board_arr[2][1] == "-"
      @board_arr[2][1] = "O"
      $board.show

    elsif @board_arr[0][0] == "-"
      @board_arr[0][0] = "O"
      $board.show
    elsif @board_arr[0][2] == "-"
      @board_arr[0][2] = "O"
      $board.show
    elsif @board_arr[2][0] == "-"
      @board_arr[2][0] = "O"
      $board.show
    elsif @board_arr[2][2] == "-"
      @board_arr[2][2] = "O"
      $board.show
    end
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
  $board = Board.new
  $board.show
  remaining_moves = 9

  until $board.check_win
    while remaining_moves > 0
      if first.name == "Computer"
        $board.computer_move
        if $board.check_win
          puts "#{first.name} wins!"
          first.wins += 1
          play_again(second, first)
        end
        remaining_moves -= 1
        if remaining_moves == 0
          break
        end
      else
        $board.player_move(first.name, first.symbol)
        if $board.check_win
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
        $board.computer_move
        $board.check_win
        if $board.check_win
          puts "#{second.name} wins!"
          second.wins += 1
          play_again(first, second)
        end
        remaining_moves -= 1
      else
        $board.player_move(second.name, second.symbol)
        $board.check_win
        if $board.check_win
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
