class Player
  CHOICES = ['rock', 'paper', 'scissors']
  COMPUTER_NAMES = ['C3PO', 'Wall-e', 'Robo-Bob', 'Johnny-5']
  
  attr_accessor :move, :name

  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end

  def set_name
    if human?
      n = ''
      loop do
        puts "What's your name?"
        n = gets.chomp.capitalize
        break unless n.empty?

        puts "Sorry, must enter a value"
      end
      self.name = n
    else
      self.name = COMPUTER_NAMES.sample
    end
  end

  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper, or scissors:"
        choice = gets.chomp.downcase
        break if CHOICES.include? choice
        puts "Invalid choice"
      end
      self.move = choice
    else
      self.move = CHOICES.sample
    end
  end

  def human?
    @player_type == :human
  end
end

# class Move
#   def initialize; end
# end

# class Rule
#   def initialize; end
# end

class RPSGame
  attr_reader :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors #{human.name}!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors #{human.name}!. "
  end

  def display_winner
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
    
    case human.move 
    when 'rock'
      puts "It's a tie" if computer.move == 'rock'
      puts "#{computer.name} Won!" if computer.move == 'paper'
      puts "#{human.name} Won!" if computer.move == 'scissors'
    when 'paper'
      puts "It's a tie" if computer.move == 'paper'
      puts "#{computer.name} Won!" if computer.move == 'scissors'
      puts "#{human.name} Won!" if computer.move == 'rock'
    when 'scissors'
      puts "It's a tie" if computer.move == 'scissors'
      puts "#{computer.name} Won!" if computer.move == 'rock'
      puts "#{human.name} Won!" if computer.move == 'paper'
    end
  end

  def play_again?
    answer = nil

    loop do 
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end

    answer == 'y' ? true : false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

def compare(move1, move2)

end

RPSGame.new.play
