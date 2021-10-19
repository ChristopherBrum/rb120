class Move
  CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  attr_reader :type, :wins, :loses

  def >(other_move)
    wins.include?(other_move.type)
  end

  def <(other_move)
    loses.include?(other_move.type)
  end
end

class Rock < Move
  def initialize
    @type = 'rock'
    @wins = ['lizard', 'scissors']
    @loses = ['paper', 'spock']
  end
end

class Paper < Move
  def initialize
    @type = 'paper'
    @wins = ['rock', 'spock']
    @loses = ['scissors', 'lizard']
  end
end

class Scissor < Move
  def initialize
    @type = 'scissors'
    @wins = ['paper', 'lizard']
    @loses = ['spock', 'rock']
  end
end

class Lizard < Move
  def initialize
    @type = 'lizard'
    @wins = ['spock', 'paper']
    @loses = ['rock', 'scissors']
  end
end

class Spock < Move
  def initialize
    @type = 'spock'
    @wins = ['scissors', 'rock']
    @loses = ['lizard', 'paper']
  end
end

class Player
  COMPUTER_NAMES = ['C3PO', 'Wall-e', 'Robo-Bob', 'Johnny-5']

  attr_accessor :name, :points, :move, :move_history

  def initialize
    @points = 0
    @name = name_prompt
    @move_history = []
  end

  def update_move_history(move)
    move_history << move.type
  end

  def find_move_type(value)
    current_move = Rock.new if value == 'rock'
    current_move = Paper.new if value == 'paper'
    current_move = Scissor.new if value == 'scissors'
    current_move = Lizard.new if value == 'lizard'
    current_move = Spock.new if value == 'spock'
    update_move_history(current_move)
    current_move
  end

  def add_point
    @points += 1
  end

  def reset_points
    @points = 0
  end
end

class Human < Player
  def name_prompt
    n = ''
    loop do
      system('clear')
      puts "What's your name?"
      n = gets.chomp.strip.capitalize
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.strip.downcase
      break if Move::CHOICES.include? choice
      puts "Invalid choice"
    end

    self.move = find_move_type(choice)
  end
end

class Computer < Player
  def name_prompt
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    self.move = find_move_type(Move::CHOICES.sample)
  end
end

class RPSGame
  POINTS_TO_WIN = 3

  attr_reader :human, :computer, :score

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def clear
    system("clear")
  end

  def display_blank_line
    puts ''
  end

  def pause
    6.times do
      print '. '
      sleep(0.65)
    end
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    display_blank_line
  end

  def display_goodbye_message
    puts "Thanks for playing #{human.name}, Goodbye!"
  end

  def display_moves
    display_blank_line
    puts "#{human.name} chose #{human.move.type}."
    puts "#{computer.name} chose #{computer.move.type}."
    display_blank_line
  end

  def update_score
    if human.move > computer.move
      human.add_point
    elsif human.move < computer.move
      computer.add_point
    end
  end

  def format_score(player)
    if human.points == 1
      puts "#{player.name} has #{player.points} point"
    else
      puts "#{player.name} has #{player.points} points"
    end
  end

  def display_score
    display_blank_line
    format_score(human)
    format_score(computer)
    display_blank_line
    display_wins_needed
    display_blank_line
  end

  def display_wins_needed
    puts "First player to #{POINTS_TO_WIN}, wins!"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end

    update_score
    display_score
  end

  def play_again?
    answer = nil

    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.strip.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y'
  end

  def winner?
    human.points >= POINTS_TO_WIN || computer.points >= POINTS_TO_WIN
  end

  def display_grand_winner
    if human.points >= POINTS_TO_WIN
      puts "#{human.name} is the GRAND WINNER!!!"
    else
      puts "#{computer.name} is the GRAND WINNER!!!"
    end
    display_blank_line
  end

  def reset_game
    human.reset_points
    computer.reset_points
  end

  def turn
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      pause
      clear
      break if winner?
    end
  end

  def display_history
    display_blank_line
    human.move_history.each_with_index do |current_move, index|
      puts "Move #{index + 1}; #{current_move}"
    end
    display_blank_line
  end

  def move_history?
    clear
    answer = nil
    loop do
      puts "Would you like to see all the moves you made? (y/n)"
      answer = gets.chomp.strip.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    display_history if answer == 'y'
  end

  def play
    clear
    display_welcome_message
    loop do
      turn
      display_grand_winner
      break unless play_again?
      reset_game
    end
    move_history?
    display_goodbye_message
  end
end

RPSGame.new.play
