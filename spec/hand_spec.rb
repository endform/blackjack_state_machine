require 'spec_helper'

describe Hand do
  it 'should start empty' do
    hand = Hand.new
    hand.optimal_score.should == 0
    hand.instance_variable_get(:@cards).length.should == 0
  end

  it 'should count aces correctly' do
    hand = Hand.new
    hand << 1
    hand << 14
    hand.min_score.should == 2
    hand.optimal_score.should == 12
    hand.bust?.should == false
    Hand.min_card_val(40).should == 1
    Hand.max_card_val(40).should == 11
  end

  it 'should count blackjacks correctly' do
    hand = Hand.new
    hand << 40
    hand << 52
    hand.blackjack?.should == true
  end

  it 'should bust on scores greater than 21' do
    hand = Hand.new
    hand << 10
    hand << 9
    hand << 8
    hand.bust?.should == true
  end

  it 'should count face card values as 10' do
    Hand.min_card_val(11).should == 10
    Hand.min_card_val(12).should == 10
    Hand.min_card_val(13).should == 10

    Hand.min_card_val(24).should == 10
    Hand.min_card_val(25).should == 10
    Hand.min_card_val(26).should == 10

    Hand.min_card_val(37).should == 10
    Hand.min_card_val(38).should == 10
    Hand.min_card_val(39).should == 10

    Hand.min_card_val(50).should == 10
    Hand.min_card_val(51).should == 10
    Hand.min_card_val(52).should == 10
  end
end
