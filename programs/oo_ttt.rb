require 'pry'

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  attr_reader :squares

  def initialize
    @squares =  {}
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{squares[1]}  |  #{squares[2]}  |  #{squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[4]}  |  #{squares[5]}  |  #{squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{squares[7]}  |  #{squares[8]}  |  #{squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked_key? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def marked?(base_marker)
    base_marker != Square::INITIAL_MARKER
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  def winning_marker
    WINNING_LINES.each do |line|
      base_marker = squares[line.first].marker

      if three_matching_markers(line, base_marker)
        return base_marker if marked?(base_marker)
      end
    end

    nil
  end

  private

  def three_matching_markers(line, base_marker)
    line.all? { |key| squares[key].marker == base_marker }
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def unmarked_key?
    marker == INITIAL_MARKER
  end

  def to_s
    @marker
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  HUMAN_GOES_FIRST = true
  WINS_NEEDED = 5

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @human_turn = HUMAN_GOES_FIRST
    @wins = { player: 0, computer: 0 }
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :human_turn, :wins
  attr_writer :wins

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
    display_blank_line
    puts "Thanks for playing Tic-Tac_Toe! Goodbye!"
    display_blank_line
  end

  def display_board
    puts "You're a '#{human.marker}' and have #{wins[:player]} wins."
    puts "Computer is an '#{computer.marker}' and has #{wins[:computer]} wins."
    display_blank_line
    puts "First player to win #{WINS_NEEDED} games is the Grand Winner!"
    display_blank_line
    board.draw
    display_blank_line
  end

  def display_results
    clear
    display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer Won!"
    else
      puts "It's a tie!"
    end
  end

  def display_grand_winner
    display_blank_line
    if wins[:player] >= WINS_NEEDED
      puts "You're the Grand Winner! Congratulations!!"
    else
      puts "The Computer is the Grand Winner!"
    end
  end

  def display_play_again_message
    puts "Let's play again!"
    display_blank_line
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def format_unmarked_squares(keys)
    if keys.size == 1
      keys.join
    else
      last = keys.pop
      "#{keys.join(', ')}, or #{last}"
    end
  end

  def prompt_next_round
    loop do
      display_blank_line
      puts "Press enter to start the next round."
      answer = STDIN.gets
      break unless answer.nil?
    end
  end

  def main_game
    loop do
      game_loop
      display_grand_winner
      break unless play_again?
      reset_score
      reset
      display_play_again_message
    end
  end

  def game_loop
    loop do
      display_board
      player_move
      display_results
      break if grand_winner?
      prompt_next_round
      reset
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.full? || someone_won?
      clear_screen_and_display_board
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
    else
      computer_moves
    end
    swap_player_turn
  end

  def human_moves
    puts "Choose a square (#{format_unmarked_squares(board.unmarked_keys)}): "
    square = nil

    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if computer_checks_offense
      board[computer_checks_offense] = computer.marker
    elsif computer_checks_defense
      board[computer_checks_defense] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def player_squares(player_marker)
    board.squares.select { |_, square| square.marker == player_marker }.keys
  end

  def computer_checks_offense
    potential_winning_square(player_squares(computer.marker))
  end

  def computer_checks_defense
    potential_winning_square(player_squares(human.marker))
  end

  def potential_winning_square(player_squares)
    winning_square = nil

    Board::WINNING_LINES.each do |line|  
      if line.select { |key| player_squares.include?(key) }.size == 2
        winning_square = line - player_squares
      end
    end

    unless winning_square.nil? || !board.unmarked_keys.include?(winning_square.first)
      winning_square.first
    end
  end

  def swap_player_turn
    @human_turn = !human_turn
  end

  def human_turn?
    human_turn
  end

  def someone_won?
    update_wins if board.someone_won?
    true if board.someone_won?
  end

  def play_again?
    answer = nil

    loop do
      display_blank_line
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "Sorry, must be y or n"
    end

    return false if answer == 'n'
    return true if answer == 'y'
  end

  def grand_winner?
    wins.any? { |_, num_of_wins| num_of_wins >= WINS_NEEDED }
  end

  def update_wins
    case board.winning_marker
    when 'X'
      wins[:player] += 1
    when 'O'
      wins[:computer] += 1
    end
  end

  def reset_score
    self.wins = { player: 0, computer: 0 }
  end

  def reset
    board.reset
    @human_turn = HUMAN_GOES_FIRST
    clear
  end
end

game = TTTGame.new
game.play
