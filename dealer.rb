require './deck'
require './hand'

class Dealer
  attr_reader :deck

  def initialize(player)
    @player = player
  end

  def deal
    @deck = Deck.new

    @hand = Hand.new
    @hand << @deck.pop
    @hand << @deck.pop

    @player.hand = Hand.new
    @player.hand << @deck.pop
    @player.hand << @deck.pop
  end

  def hit_player
    @player.hand << @deck.pop
  end
end
