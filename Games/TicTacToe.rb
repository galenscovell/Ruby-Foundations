
# Tic-tac-toe game designed with emphasis on OOP
# Without AI, for now. Also could use some refactoring, (checking win conditions).

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
    @board_arr[row - 1][column - 1] = symbol
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
    if @board_arr[row - 1][column - 1] == "X" || @board_arr[row - 1][column - 1] == "O"
      puts "That spot is already taken."
      player_move(player, symbol)
    else
      update(symbol, row, column)
    end
  end

  def player_move(player, symbol)
    puts "\n#{player}'s turn (#{symbol}'s)."
    move_choice = [0, 0]
    until move_choice[0].between?(1, 3) && move_choice[1].between?(1, 3)
      puts "Place #{symbol} where? (row column) "
      input = gets.chomp.split(" ")
      move_choice[0] = input[0].to_i
      move_choice[1] = input[1].to_i
    end
    check_move(player, symbol, move_choice[0], move_choice[1])
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

# Main game flow
def game_play(player_1, player_2)
  $board = Board.new
  $board.show
  remaining_moves = 9

  until $board.check_win
    while remaining_moves > 0
      $board.player_move(player_1.name, player_1.symbol)
      if $board.check_win
        puts "Player one wins!"
        player_1.wins += 1
        play_again(player_1, player_2)
      end
      remaining_moves -= 1
      if remaining_moves == 0
        break
      end
      $board.player_move(player_2.name, player_2.symbol)
      $board.check_win
      if $board.check_win
        puts "Player two wins!"
        player_2.wins += 1
        play_again(player_1, player_2)
      end
      remaining_moves -= 1
    end
    puts "No moves left. Draw!"
    break
  end
  play_again(player_1, player_2)
end

# Player setup
puts "\nThis is Tic-Tac-Toe, the game of pure skill."

puts "\nWho commands the X's?"
name_1 = gets.chomp
symbol_1 = "X"
player_1 = Player.new(name_1, symbol_1)

puts "Who sends forth the O's?"
name_2 = gets.chomp
symbol_2 = "O"
player_2 = Player.new(name_2, symbol_2)

game_play(player_1, player_2)