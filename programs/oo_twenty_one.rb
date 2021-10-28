require 'pry'

module Displayable
  def clear
    system 'clear'
  end

  def display_blank_line
    puts ''
  end

  def display_line
    puts '--------------------------'
  end

  def headline_prompt(message)
    puts "-----> #{message} <-----"
    display_blank_line
  end

  def prompt(message)
    puts "--> #{message}"
  end

  def prompt_with_space(message)
    prompt(message)
    display_blank_line
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
    prompt_with_space("Goal:
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
        The dealer busts")

    loop do
      prompt("Press enter when you're done with the rules")
      answer = STDIN.gets
      break unless answer.nil?
    end
  end

  def display_table
    clear
    display_cards
    display_scores
  end

  def display_cards
    player.display_hand
    dealer.display_hand
  end

  def display_hand
    headline_prompt("#{name}'s Hand")

    hand.each do |card|
      prompt("#{card.face} of #{card.suit}")
    end

    prompt('Unkown card') if hand.size < 2
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
    prompt("#{name}'s' total is #{total}")
  end

  def display_continue_prompt
    prompt_with_space("Press enter when you're ready to continue:")
    answer = STDIN.gets
  end
end

class Player
  include Displayable

  attr_accessor :name, :hand

  def initialize(name=nil)
    @name = name
    @hand = []
  end

  def hit(card)
    hand << card
  end

  def stay(dealer)
    prompt_with_space("#{name} stays. Now it's #{dealer.name}'s turn!")
    display_continue_prompt
  end

  def bust?
    total > 21
  end

  def total
    total = 0
    hand.each { |card| total += card.find_card_value }
    total
  end
end

class Dealer < Player
  DEALER_NAMES = ['Rufus', 'Midge', 'Barney', 'Petunia', 'Ducky']

  def initialize
    super(chose_dealer_name)
  end

  def chose_dealer_name
    DEALER_NAMES.sample
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
  include Displayable

  attr_accessor :deck
  attr_reader :player, :dealer

  def initialize
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    welcome

    loop do
      deal_cards
      display_table
      player_turn
      # dealer_turn
      # show_result
      break 
    end
  end

  private

  def welcome
    clear
    headline_prompt("Welcome to Twenty-One")
    name_prompt
    rules_prompt
  end

  def name_prompt
    answer = nil

    loop do
      prompt_with_space("Please enter your name:")
      answer = gets.chop.strip.capitalize
      break if !answer.empty?
      prompt_with_space("Sorry, invalid input.")
    end

    player.name = answer
  end

  def rules_prompt
    clear
    question = "Would you like to view the rules for Twenty-One? (y or n):"
    answer = display_question_get_answer(question, %w(y n))
    display_rules if answer == 'y'
  end

  def deal_cards
    clear
    2.times { |_| player.hit(deck.take_card) }
    dealer.hit(deck.take_card)
  end

  def player_turn
    loop do
      question = "Hit or stay, #{player.name}?"
      answer = display_question_get_answer(question, %w(h s))
      player.hit(deck.take_card)
      display_table
      break if answer == 's' || player.bust?
    end
    player_turn_end(answer)
  end

  def player_turn_end(answer)
    clear
    display_scores
    if answer == 's'
      player.stay(dealer)
    elsif player.bust?

    end
  end
end

TwentyOne.new.start