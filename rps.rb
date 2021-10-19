class Move
  CHOICES = ['rock', 'paper', 'scissors', 'lizard', 'spock']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissors?
    @value == 'scissors'
  end

  def lizard?
    @value == 'lizard'
  end

  def spock?
    @value == 'spock'
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (rock? && other_move.lizard?) ||
      (paper? && other_move.spock?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?) ||
      (scissors? && other_move.lizard?) ||
      (lizard? && other_move.spock?) ||
      (lizard? && other_move.paper?) ||
      (spock? && other_move.scissors?) ||
      (spock? && other_move.rock?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (rock? && other_move.spock?) ||
      (paper? && other_move.scissors?) ||
      (paper? && other_move.lizard?) ||
      (scissors? && other_move.rock?) ||
      (scissors? && other_move.spock?) ||
      (lizard? && other_move.rock?) ||
      (lizard? && other_move.scissors?) ||
      (spock? && other_move.paper?) ||
      (spock? && other_move.lizard?)
  end

  def to_s
    @value
  end
end

class Rock
  def beats?
    
  end
end

class Paper
end

class Scissor
end

class Lizard
end

class Spock
end

class Player
  COMPUTER_NAMES = ['C3PO', 'Wall-e', 'Robo-Bob', 'Johnny-5']

  attr_accessor :move, :name, :points

  def initialize
    @points = 0
    set_name
  end

  def add_point
    @points += 1
  end

  def reset_points
    @points = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?

      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, scissors, lizard or spock:"
      choice = gets.chomp.downcase
      break if Move::CHOICES.include? choice
      puts "Invalid choice"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = COMPUTER_NAMES.sample
  end

  def choose
    self.move = Move.new(Move::CHOICES.sample)
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
    sleep(4)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors, Lizard, Spock, #{human.name}!"
    display_blank_line
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors, Lizard, Spock,
      #{human.name}!"
  end

  def display_moves
    display_blank_line
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
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
      answer = gets.chomp.downcase
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
      break if winner?
    end
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
    display_goodbye_message
  end
end

RPSGame.new.play
