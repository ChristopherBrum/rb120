=begin 
Nouns and Verbs
TTT is a 2 player board game played on a 3x3 grid. Players take turns marking a square. First player to mark 3 squares in a row wins. 

Nouns: player, board, square, grid
Verbs: play, mark

Board
Square 
Player
- mark
- play 

=end

class Board
  INITIAL_MARKER = " "

  def initialize
    @squares =  {}
    (1..9).each { |key| @squares[key] = Square.new(INITIAL_MARKER) }
  end

  def get_square_at(key)
    @squares[key]
  end
end

class Square
  def initialize(marker)
    @marker = marker
  end

  def to_s
    @marker
  end
end

class Player
  def initialize
    
  end

  def mark
  end
end


class TTTGame
  attr_reader :board

  def initialize
    @board = Board.new
  end

  def clear
    system('clear')
  end

  def display_blank_line
    puts ''
  end

  def display_welcome_message
    puts "Welcome to Tic-Tac-Toe!"
    display_blank_line  
  end

  def display_goodbye_message
    puts "Thanks for playing Tic-Tac_Toe! Goodbye!"
  end

  def display_board
    puts "     |     |"
    puts "  #{board.get_square_at(1)}  |  #{board.get_square_at(2)}  |  #{board.get_square_at(3)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(4)}  |  #{board.get_square_at(5)}  |  #{board.get_square_at(6)}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{board.get_square_at(7)}  |  #{board.get_square_at(8)}  |  #{board.get_square_at(9)}"
    puts "     |     |"
    display_blank_line
  end

  def play
    clear
    display_welcome_message
    loop do
      display_board
      break
      first_player_moves
      break if someone_won? || board_full?

      second_player_moves
      break if someone_won? || board_full?
    end
    # display_results
    display_goodbye_message
  end
end

game = TTTGame.new
game.play
