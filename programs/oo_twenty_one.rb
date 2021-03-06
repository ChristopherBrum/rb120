module Rules
  RULES = "Goal:
     Try to get as close to 21 as possible, without going over.
     If you go over 21, it's a 'bust' and you lose.

   Card values:
     Number cards (2-10) have their face value
     Jacks, Kings and Queens are worth 10.
     Ace can be worth 1 or 11.

   Player Turn:
     The dealer and the player are initially dealt 2 two cards.
     The players cards are revealed.
     The dealer only reveals one card.
     The player can either;
       'hit' (take another card)
         or
       'stay' (keep the cards they have)

   Dealer Turn:
     The dealer reveals their second card.
     The dealer must 'hit' until they have at least 17.

   Winning:
     The dealer wins if:
       Their total is greater than the players
         or
       They have 21
         or
       The player busts

     The player wins if:
       Their total is greater than the dealers
         or
       The dealer busts"
end

module Display
  include Rules

  def clear
    system 'clear'
  end

  def display_blank_line(lines=1)
    lines.times { |_| puts '' }
  end

  def display_line
    puts '--------------------------------'
  end

  def headline_prompt(message)
    puts "--------> #{message} <--------"
    display_blank_line
  end

  def prompt(message)
    puts "-- #{message}"
  end

  def prompt_with_space(message)
    prompt(message)
    display_blank_line
  end

  def display_pause_with_dots
    3.times do
      print '. '
      sleep(1)
    end
  end

  def display_question_get_answer(question, accepted_input)
    answer = nil

    loop do
      prompt_with_space(question)
      answer = gets.chomp.strip.downcase
      break if accepted_input.include?(answer)
      prompt_with_space("Sorry, invalid input.")
    end

    answer
  end

  def display_rules
    clear
    prompt_with_space(Rules::RULES)

    loop do
      prompt("Press enter when you're done with the rules")
      answer = STDIN.gets
      break unless answer.nil?
    end
  end

  def display_table
    clear
    display_wins
    player.display_hand
    dealer.display_hand
    display_scores
  end

  def display_wins
    headline_prompt("First player to win #{TwentyOne::WINS_NEEDED} \
rounds is the Grand Winner")
    prompt("#{player.name}'s wins: #{player.wins}")
    prompt_with_space("#{dealer.name}'s wins: #{dealer.wins}")
  end

  def display_hand
    headline_prompt("#{name}'s Hand")

    hand.each { |card| prompt("#{card.face} of #{card.suit}") }

    prompt('Unkown Card') if hand.size < 2
    display_blank_line
  end

  def display_scores
    display_line
    player.display_score
    dealer.display_score
    display_line
    display_blank_line
  end

  def display_score
    prompt("#{name}'s total is #{total}")
  end

  def display_grand_winner
    if player.won?
      headline_prompt("Congrats #{player.name}, you're the Grand Winner!")
    elsif dealer.won?
      headline_prompt("#{dealer.name} is the Grand Winner!")
    end
  end

  def display_continue_prompt
    prompt("Press enter when you're ready to continue:")
    STDIN.gets
  end
end

class Participant
  include Display

  attr_accessor :name, :hand, :wins

  def initialize(name=nil)
    @name = name
    @hand = []
    @wins = 0
  end

  def hit(card)
    hand << card
  end

  def stay(dealer)
    prompt_with_space("#{name} stays. Now it's #{dealer.name}'s turn!")
    display_continue_prompt
  end

  def bust?
    total > TwentyOne::MAX_TOTAL
  end

  def total
    total = 0
    hand.each { |card| total += card.find_card_value }
    hand.each do |card|
      total -= 10 if card.face == 'Ace' && total > TwentyOne::MAX_TOTAL
    end
    total
  end

  def won?
    wins == TwentyOne::WINS_NEEDED
  end

  def <=>(other_total)
    total <=> other_total
  end
end

class Player < Participant
  def choose_name
    answer = nil

    loop do
      prompt_with_space("Please enter your name:")
      answer = gets.chop.strip.capitalize
      break if !answer.empty?
      prompt_with_space("Sorry, invalid input.")
    end

    self.name = answer
  end
end

class Dealer < Player
  DEALER_NAMES = ['Rufus', 'Midge', 'Barney', 'Petunia', 'Ducky']

  def initialize
    super(DEALER_NAMES.sample)
  end

  def hit(card)
    if hand.size >= 2
      prompt_with_space("#{name} hits!")
      display_pause_with_dots
    end
    hand << card
  end

  def should_hit?(player_total)
    (total < TwentyOne::MIN_TOTAL_TO_STAY) ||
      (total >= TwentyOne::MIN_TOTAL_TO_STAY && total < player_total)
  end

  def should_stay?(player_total)
    ((total >= TwentyOne::MIN_TOTAL_TO_STAY) &&
      (total >= player_total) && (!bust?))
  end
end

class Deck
  attr_reader :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card::FACES.each do |face|
        @cards << Card.new(suit, face)
      end
    end
  end

  def take_card
    card = cards.sample
    cards.delete(card)
  end
end

class Card
  SUITS = ['H', 'D', 'C', 'S']
  FACES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

  def initialize(suit, face)
    @suit = suit
    @face = face
  end

  def suit
    case @suit
    when 'H' then 'Hearts'
    when 'D' then 'Diamonds'
    when 'C' then 'Clubs'
    when 'S' then 'Spades'
    end
  end

  def face
    case @face
    when 'J' then 'Jack'
    when 'Q' then 'Queen'
    when 'K' then 'King'
    when 'A' then 'Ace'
    else
      @face
    end
  end

  def jack?
    face == 'Jack'
  end

  def queen?
    face == 'Queen'
  end

  def king?
    face == 'King'
  end

  def ace?
    face == 'Ace'
  end

  def find_card_value
    if jack? || queen? || king?
      10
    elsif ace?
      11
    else
      face.to_i
    end
  end
end

class TwentyOne
  WINS_NEEDED = 5
  MAX_TOTAL = 21
  MIN_TOTAL_TO_STAY = 17

  include Display

  attr_reader :game_selection

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    welcome
    loop do
      game_loop
      display_grand_winner
      break unless play_again?
      full_reset
    end
    goodbye
  end

  private

  attr_accessor :deck
  attr_reader :player, :dealer

  def welcome
    clear
    headline_prompt("Welcome to the card game Twenty-One")
    player.choose_name
    rules_prompt
  end

  def rules_prompt
    clear
    question = "Would you like to view the rules for Twenty-One? (y or n):"
    answer = display_question_get_answer(question, %w(y yes n no))
    display_rules if answer.start_with?('y')
  end

  def game_loop
    loop do
      play_round
      determine_results
      break if grand_winner?
      reset
    end
  end

  def play_round
    loop do
      deal_cards
      display_table
      player_turn
      break if player.bust?
      dealer_turn
      break if dealer.bust?
      break
    end
  end

  def deal_cards
    clear
    2.times { |_| player.hit(deck.take_card) }
    dealer.hit(deck.take_card)
  end

  def player_total
    player.total
  end

  def dealer_total
    dealer.total
  end

  def player_total_over_dealer_total
    player_total > dealer_total
  end

  def player_total_under_dealer_total
    dealer_total > player_total
  end

  def player_turn
    loop do
      question = "Hit or stay, #{player.name}?"
      answer = display_question_get_answer(question, %w(h hit s stay))
      break if answer.start_with?('s')
      player.hit(deck.take_card)
      display_table
      break if player.bust?
    end
  end

  def dealer_turn
    dealer_flips_card
    loop do
      dealer.hit(deck.take_card) if dealer.should_hit?(player_total)
      display_table
      break if dealer.bust? || dealer.should_stay?(player_total)
    end
  end

  def dealer_flips_card
    display_table
    prompt_with_space("#{dealer.name} flips their other card over.")
    display_pause_with_dots
    dealer.hit(deck.take_card)
    display_table
  end

  def determine_results
    update_wins
    if player.bust? || dealer.bust?
      return_who_busted
    elsif player_total == dealer_total
      prompt_with_space("It's a draw!")
    else
      return_who_won
    end
    display_continue_prompt
  end

  def return_who_busted
    if player.bust?
      prompt_with_space("#{player.name} busts!")
    elsif dealer.bust?
      prompt_with_space("#{dealer.name} busts!")
    end
  end

  def return_who_won
    if player_total_over_dealer_total
      prompt_with_space("#{player.name} wins!")
    elsif player_total_under_dealer_total
      prompt_with_space("#{dealer.name} wins!")
    end
  end

  def increment_player_wins
    player.wins += 1
  end

  def increment_dealer_wins
    dealer.wins += 1
  end

  def dealer_wins?
    (player_total_under_dealer_total && !dealer.bust?) || player.bust?
  end

  def player_wins?
    (player_total_over_dealer_total && !player.bust?) || dealer.bust?
  end

  def update_wins
    if dealer_wins?
      increment_dealer_wins
    elsif player_wins?
      increment_player_wins
    end
  end

  def grand_winner?
    player.won? || dealer.won?
  end

  def play_again?
    question = "Would you like to play again?"
    answer = display_question_get_answer(question, %w(y yes n no))
    answer.start_with?('y')
  end

  def reset
    self.deck = Deck.new
    player.hand = []
    dealer.hand = []
  end

  def full_reset
    reset
    player.wins = 0
    dealer.wins = 0
  end

  def goodbye
    prompt_with_space("Thanks for playing Twenty-One, #{player.name}! Goodbye!")
  end
end

TwentyOne.new.start
