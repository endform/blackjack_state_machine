class Deck
  def initialize
    @cards = (1..52).to_a.shuffle
  end

  def pop
    @cards.pop
  end

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
      [0x2663].pack('U*')
    elsif card.between?(14,26)
      [0x2666].pack('U*')
    elsif card.between?(27,39)
      [0x2665].pack('U*')
    elsif card.between?(40,52)
      [0x2660].pack('U*')
    else
      'Joker'
    end
  end

  def self.pretty_card(card)
    card_ordinal = card % 13
    card_ordinal = 13 if card_ordinal == 0
    name = @@names[card_ordinal] || (card_ordinal).to_s
    of = card_suit(card)
    "#{name} of #{of}"
  end
end
