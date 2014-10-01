
# Mastermind game with focus on OOP

class Player
  def initialize
    @wins = 0
  end
  def guess_code

  end
  def make_code

  end
end

class Computer
  def initialize
    @wins = 0
  end
  def guess_code

  end
  def make_code

  end
end

class Mastermind
  def initialize
    @board_arr = ["[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]", "[ ]"]
    @turns = 6
  end

  def draw
    puts "\nGuesses remaining: #{@turns}"
    puts "\n|" + @board_arr.join + "|"
    puts "|   GUESS   ||   HINT    |"
  end

  def update

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

def codemaker()

end

def codebreaker(player)
  $board = Mastermind.new
  $board.draw
end

def how_to_play(player)

end

human_player = Player.new
menu(human_player)