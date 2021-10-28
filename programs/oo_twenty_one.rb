=begin
  Twenty-One is a card game consisting of a dealer and a player where they try to get as close to 21 without going over. 

  Game Overview:
  - both participants are dealt 2 cards fro a 52 card deck
  - player takes first turn, can sya 'hit' or 'stay'
  - if player busts they lose, if not then the dealer goes
  - dealer 'hits' until they reach at least 17
  - if dealer busts player wins, otherwise the person with the highest total wins
  - if theres a tie there is no winner

  Nouns: dealer, player, participant, deck, card, game, total
  Verbs: deal, hit, stay, busts

  Player
    - hit
    - stay
    - bust?
    - total
  Dealer
    - hit
    - stay
    - bust?
    - total
    - deal (should this be here, or in Deck?)
  Participant

  Deck
    - deal (should this be here, or in Dealer?)
  Card

  Game
    - start

=end

require 'pry'

module Displayable

  def clear
    system 'clear'
  end

  def display_blank_line
    puts ''
  end

  def headline_prompt(message)
    puts "-----> #{message} <-----"
  end

  def headline_prompt_with_space(message)
    display_blank_line
    headline_prompt(message)
    display_blank_line
  end

  def prompt(message)
    puts "--> #{message}"
  end

  def prompt_with_space(message)
    display_blank_line
    prompt(message)
    display_blank_line
  end

  def display_rules
    clear
    prompt_with_space("Rules:
      Try to get as close to 21 as possible, without going over. 
      If you go over 21, it's a 'bust' and you lose.

    Card values:
      Number cards (1-10) have their face value
      Jacks, Kings and Queens are worth 10.
      Ace can be either 1 or 11.

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
        Their total is hreater than the dealers
          or
        The dealer busts")
    
    loop do              
      prompt("Press enter when you're done with the rules")
      answer = STDIN.gets
      break unless answer.nil?
    end
  end

  def display_hand
    headline_prompt_with_space("#{name}'s Hand")

    hand.each do |card|
      prompt("#{card.face} of #{card.suit}")
    end

    prompt('Unkown card') if hand.size < 2
    prompt_with_space("#{name}'s' total is #{total}")
  end

end

class Player
  include Displayable

  attr_accessor :name, :hand

  def initialize(name=nil)
    @name = name
    @hand = []
  end

  def add_to_hand(card)
    hand << card
  end

  def hit
  end

  def stay
  end

  def bust?
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
    deal_cards
    show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
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
    answer = nil

    loop do
      prompt_with_space("Would you like to view the rules for Twenty-One? (y or n):")
      answer = gets.chomp.strip.downcase
      break if %w(y n).include?(answer)
      prompt_with_space("Sorry, invalid input.")
    end

    display_rules if answer == 'y'
  end

  def deal_cards
    clear
    2.times { |_| player.add_to_hand(deck.take_card) }
    dealer.add_to_hand(deck.take_card)
  end

  def show_initial_cards
    player.display_hand
    dealer.display_hand
  end
end

TwentyOne.new.start
