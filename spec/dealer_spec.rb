require 'spec_helper'

describe Dealer do
  it 'should deal 2 cards to dealer and player' do
    player = Player.new
    dealer = Dealer.new(player)

    dealer.deal

    dealer.hand.instance_variable_get(:@cards).length.should == 2
    player.hand.instance_variable_get(:@cards).length.should == 2

    dealer.deck.instance_variable_get(:@cards).length.should == 48
  end

  it 'should not hit if hand is bust' do
    player = Player.new
    dealer = Dealer.new(player)
    dealer.instance_variable_set(:@hand, Hand.new)

    dealer.hand << 10
    dealer.hand << 9
    dealer.hand << 8
    dealer.should_hit?.should == false
  end

  it 'should hit if below 17' do
    player = Player.new
    dealer = Dealer.new(player)
    dealer.instance_variable_set(:@hand, Hand.new)

    dealer.hand << 10
    dealer.should_hit?.should == true
  end

  it 'should not hit if above 17' do
    player = Player.new
    dealer = Dealer.new(player)
    dealer.instance_variable_set(:@hand, Hand.new)

    dealer.hand << 10
    dealer.hand << 9
    dealer.should_hit?.should == false
  end
end
