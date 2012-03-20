require 'spec_helper'

describe Deck do
  it 'should say 1..13 are clubs' do
    (1..13).map { |i|
      Deck.card_suit(i)
    }.uniq.should == [[0x2663].pack('U*')]
  end

  it 'should say 14..26 are diamonds' do
    (14..26).map { |i|
      Deck.card_suit(i)
    }.uniq.should == [[0x2666].pack('U*')]
  end

  it 'should say 27..39 are hearts' do
    (27..39).map { |i|
      Deck.card_suit(i)
    }.uniq.should == [[0x2665].pack('U*')]
  end

  it 'should say 40..52 are spades' do
    (40..52).map { |i|
      Deck.card_suit(i)
    }.uniq.should == [[0x2660].pack('U*')]
  end

  it 'should have 52 cards' do
    deck = Deck.new
    deck.instance_variable_get(:@cards).length.should == 52
    deck.pop
  end

  it 'should have 51 cards after popping once' do
    deck = Deck.new
    deck.pop
    deck.instance_variable_get(:@cards).length.should == 51
  end
end
