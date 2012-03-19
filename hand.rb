class Hand
  def initialize()
    @cards = []
  end

  def <<(card)
      @cards << card
  end

  # we only programmatically need to generate the min_count of a hand
  # this is for the loss check
  def min_count
    @cards.inject(0) { |count, card|
      count += (card % 13)
    }
  end

  def max_non_bust_count
    countable = @cards.map { |card| card % 13 }
    aces = countable.select { |card| card == 1 }.length
    
  end

  def black_jack?
    false if @cards.length > 2
    countable = @cards.map { |card| card % 13 }.sort
    if countable[0] == 1 && countable[1] > 9
      true
    else
      false
    end
  end

  def bust?
    min_count > 21
  end

  def to_s
    @cards.map { |card|
      Deck.card_name(card)
    }.join(', ')
  end
end
