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

class Player
  attr_accessor :name

  def initialize
    @name = name
    @hand = hand
  end

  def hand
  end

  def hit
  end

  def stay
  end

  def bust?
  end

  def total
  end
end

class Dealer < Player
  def hand
  end

  def deal
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

  def deal #?
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

  end

  def queen?

  end

  def king?

  end

  def ace?

  end
end

class TwentyOne
  def initialize
    @deck = deck
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    deal_cards
    # show_initial_cards
    # player_turn
    # dealer_turn
    # show_result
  end

  private

  attr_accessor :deck

  def deal_cards
    deck = Deck.new
    binding.pry
  end

end

TwentyOne.new.start
