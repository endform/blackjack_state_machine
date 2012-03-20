require 'deck'
require 'hand'

class Dealer
  attr_reader :deck, :hand

  def initialize(player)
    @player = player
  end

  def deal
    @deck = Deck.new

    @hand = Hand.new
    @hand << @deck.pop
    @hand << @deck.pop
    puts "Dealer starts with hand #{@hand}"

    @player.hand = Hand.new
    @player.hand << @deck.pop
    @player.hand << @deck.pop

    :dealt
  end

  def hit_player
    card = @deck.pop
    puts Deck.pretty_card(card)
    @player.hand << card
  end

  def should_hit?
    !@hand.bust? && @hand.optimal_score < 17
  end

  def dealer_play
    puts "dealer starts with hand: #{@hand}"
    # optimal is also losing when there is no choice
    while should_hit?
      drawn = @deck.pop
      @hand << drawn
      puts "dealer hits and draws #{Deck.pretty_card(drawn)}"
    end

    if @hand.bust?
      puts "dealer busted"
    else
      puts "dealer finished with score of #{@hand.optimal_score}"
    end

    :dealer_finished
  end
end
