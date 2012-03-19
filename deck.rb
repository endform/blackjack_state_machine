class Deck
  # the suits of the deck are:
  # clubs    1..13
  # diamonds 14..26
  # hearts   27..39
  # spades   40..52
  @@names = {
    1 => 'ace',
    11 => 'jack',
    12 => 'queen',
    13 => 'king'
  }

  def self.card_suit(card)
    if card.between?(1,13)
      "\u2663"
    elsif card.between?(14,26)
      "\u2666"
    elsif card.between?(27,39)
      "\u2665"
    elsif card.between?(40,52)
      "\u2660"
    else
      'Joker'
    end
  end

  def self.card_name(card)
    name = @@names[card % 13] || card.to_s
    of = card_suit(card)
    "#{name} of #{of}"
  end

  def initialize
    @cards = (1..52).to_a.shuffle
  end

  def pop
    @cards.pop
  end
end
