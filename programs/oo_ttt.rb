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
  COMPUTER_NAMES = ['Hal', 'Wall-E', 'Johnny-5', 'R2D2', 'Roomba', 'Safeway Self-Checkout Machine']

  attr_accessor :marker, :name

  def initialize
    @marker
    @name
  end
end

class TTTGame
  X_MARKER = "X"
  O_MARKER = "O"
  WINS_NEEDED = 5
  CENTER_SQUARE = 5

  def initialize
    @board = Board.new
    @human = Player.new
    @computer = Player.new
    @human_turn = true
    @human_goes_first = true
    @wins = { player: 0, computer: 0 }
  end

  def play
    clear
    display_welcome_message
    choose_marker
    choose_names
    display_players_names
    main_game
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer, :human_turn, :wins, :human_goes_first
  attr_writer :wins, :human_turn, :human_goes_first

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
    puts "Thanks for playing Tic-Tac_Toe #{human.name}! Goodbye!"
    display_blank_line
  end

  def display_players_names
    clear
    puts "Today's game of Tic-Tac-Toe features #{human.name} Vs. #{computer.name}!!"
    sleep(3)
    display_blank_line
  end

  def display_board
    puts "#{human.name} is the '#{human.marker}' and has #{wins[:player]} wins."
    puts "#{computer.name} is the '#{computer.marker}' and has #{wins[:computer]} wins."
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
      puts "#{human.name} won!"
    when computer.marker
      puts "#{computer.name} Won!"
    else
      puts "It's a tie!"
    end
  end

  def display_grand_winner
    display_blank_line
    if wins[:player] >= WINS_NEEDED
      puts "#{human.name} is the Grand Winner! Congratulations!!"
    else
      puts "#{computer.name} is the Grand Winner!"
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
    elsif keys.size == 2
      keys.join(' ')
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

  def choose_marker
    answer = nil

    loop do
      puts "Choose your marker (X or O): "
      answer = gets.chomp.strip.downcase
      break if %w(x o).include?(answer[0])
      puts "Sorry, that's not a valid choice. Please enter X or O"
      display_blank_line
    end

    assign_markers(answer[0])
  end

  def assign_markers(human_marker)
    if human_marker == 'x'
      human.marker = X_MARKER
      computer.marker = O_MARKER
    else
      human.marker = O_MARKER
      computer.marker = X_MARKER
    end
  end

  def choose_names
    name = nil

    loop do
      display_blank_line
      puts "Please enter your name: "
      name = gets.chomp.strip.capitalize
      break if !name.empty?
      puts "Sorry, that's not a valid choice. Please enter your name"
    end

    human.name = name
    computer.name = Player::COMPUTER_NAMES.sample
  end

  def main_game
    loop do
      prompt_starting_player
      game_loop
      display_grand_winner
      break unless play_again?
      reset_score
      reset
      display_play_again_message
    end
  end

  def prompt_starting_player
    answer = nil

    puts "Who would you like to go first?"
    loop do
      display_starting_player_options
      answer = gets.chomp
      break if %W(1 2 3).include?(answer) # answer.start_with?('h', 'c', 'r')
      puts "Sorry, that's not a valid choice."
    end

    starting_player(answer)
    clear
  end

  def display_starting_player_options
    puts "  Enter 1 for #{human.name}."
    puts "  Enter 2 for #{computer.name}."
    puts "  Enter 3 to choose randomly."
    display_blank_line
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
    if computer_checks_offense_move
      computer_makes_offensive_move
    elsif computer_checks_defense_move
      computer_makes_defensive_move
    elsif space_five_free?
      board[CENTER_SQUARE] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def computer_checks_offense_move
    potential_winning_square(player_squares(computer.marker))
  end

  def computer_checks_defense_move
    potential_winning_square(player_squares(human.marker))
  end

  def computer_makes_offensive_move
    board[computer_checks_offense_move] = computer.marker
  end

  def computer_makes_defensive_move
    board[computer_checks_defense_move] = computer.marker
  end

  def player_squares(player_marker)
    board.squares.select { |_, square| square.marker == player_marker }.keys
  end

  def potential_winning_square(player_squares)
    winning_squares = []

    Board::WINNING_LINES.each do |line|
      if line.select { |key| player_squares.include?(key) }.size == 2
        winning_squares << (line - player_squares).first
      end
    end

    winners = winning_squares.select { |key| board.unmarked_keys.include?(key) }

    return nil if winners.empty?
    winners.first
  end

  def space_five_free?
    board.unmarked_keys.include?(CENTER_SQUARE)
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
      clear
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
    when human.marker
      wins[:player] += 1
    when computer.marker
      wins[:computer] += 1
    end
  end

  def reset_score
    self.wins = { player: 0, computer: 0 }
  end

  def reset
    board.reset
    reset_starting_player
    clear
  end

  def reset_starting_player
    self.human_turn = if human_goes_first
                        true
                      else
                        false
                      end
  end

  def starting_player(player)
    if player.start_with?('1')
      assign_starting_player(true)
    elsif player.start_with?('2')
      assign_starting_player(false)
    else
      random_answer = [true, false].sample
      assign_starting_player(random_answer)
    end
  end

  def assign_starting_player(bool)
    self.human_turn = bool
    self.human_goes_first = bool
  end
end

game = TTTGame.new
game.play
