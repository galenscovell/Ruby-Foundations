
# Tic-tac-toe game designed with emphasis on OOP
# Without AI, for now

class Player

  def initialize(name, symbol)
    @name = name
    @symbol= symbol
    @wins = 0
    @losses = 0
    puts "A new challenger has appeared! #{name} batting for #{symbol}!"
  end

end

class Board

  def initialize
    @board_arr = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
    @game_over = false
  end

  def show
    p @board_arr[0]
    p @board_arr[1]
    p @board_arr[2]
  end

  def update(symbol, row, column)
    @board_arr[row - 1][column - 1] = symbol
  end

  def check_win

  end

  def player_move(symbol)
    row_choice = 0
    until row_choice.between?(1, 3)
      puts "Enter row choice: "
      row_choice = gets.chomp.to_i
    end
    column_choice = 0
    until column_choice.between?(1, 3)
      puts "Enter column choice: "
      column_choice = gets.chomp.to_i
    end
    board.update(symbol, row_choice, column_choice)
    board.show
  end

end

puts "Player X Name?"
name_1 = gets.chomp
symbol_1 = "X"
player_one = Player.new(name_1, symbol_1)

puts "Player O Name?"
name_2 = gets.chomp
symbol_2 = "O"
player_two = Player.new(name_2, symbol_2)

board = Board.new
board.show

until board.check_win
  board.player_move(symbol_1)
  board.check_win
  board.player_move(symbol_2)
  board.check_win
end




