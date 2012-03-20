class Hand
  def initialize()
    @cards = []
  end

  def <<(card)
      @cards << card
  end

  def min_score
    @cards.inject(0) { |count, card|
      count + Hand.min_card_val(card)
    }
  end

  # exists because of hard and soft scores
  def optimal_score
    return if bust?
    countable = @cards.map { |card| Hand.max_card_val(card) }
    high_aces = countable.select { |card| card == 11 }.length

    sum = countable.inject(0) { |sum, card_val| sum + card_val }
    return sum if sum <= 21
    high_aces.times {
      sum -= 10
      break if sum <= 21
    }
    sum
  end

  def blackjack?
    false if @cards.length > 2
    countable = @cards.map { |card| Hand.max_card_val(card) }.sort
    if countable[0] + countable[1] == 21
      true
    else
      false
    end
  end

  def bust?
    min_score > 21
  end

  def to_s
    @cards.map { |card|
      Deck.pretty_card(card)
    }.join(' , ')
  end

  def self.min_card_val(card)
    card_val = card % 13
    card_val = 10 if card_val > 10 || card_val == 0
    card_val
  end

  def self.max_card_val(card)
    card_val = card % 13
    if card_val == 1
      card_val = 11
    elsif card_val > 10 || card_val == 0
      card_val = 10
    end
    card_val
  end
end
