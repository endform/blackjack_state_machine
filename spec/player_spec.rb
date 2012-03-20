require 'spec_helper'

describe Player do
  it 'should start with 500 chips' do
    player = Player.new
    player.chips.should == 500
  end

  it 'should take max bet of 100' do
  end

  it 'should take only positive integer bets' do
  end

  it 'should always return :player_placed_bet' do
  end

  it 'should not error when given garbage' do
  end
end
