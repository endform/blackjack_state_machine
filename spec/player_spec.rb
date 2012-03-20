require 'spec_helper'

describe Player do
  it 'should start with 500 chips' do
    player = Player.new
    player.chips.should == 500
  end

  it 'should take max bet of 100 when wagering' do
    player = Player.new
    called = 0
    player.define_singleton_method :read_cli, lambda {
      puts 'called'
      if called == 0
        called +=1
        '101'
      else
        '100'
      end
    }

    player.wager.should == :player_placed_bet
    player.bet.should == 100
  end

  it 'should take only positive integer bets when wagering' do
    player = Player.new
    called = 0
    player.define_singleton_method :read_cli, lambda {
      if called == 0
        called +=1
        '-10'
      else
        '100'
      end
    }

    player.wager.should == :player_placed_bet
    player.bet.should == 100
  end

  it 'should not error when given garbage' do
    player = Player.new
    called = 0
    player.define_singleton_method :read_cli, lambda {
      if called == 0
        called +=1
        'xxXXX1231[[{]]-10'
      else
        '100'
      end
    }

    player.wager.should == :player_placed_bet
    player.bet.should == 100
  end

  it 'should subtract bet from chips after wager' do
    player = Player.new
    called = 0
    player.define_singleton_method :read_cli, lambda { '100' }

    player.wager
    player.chips.should == 400
  end

  it 'should return bet to chips after push' do
    player = Player.new
    player.instance_variable_set(:@bet, 100)
    player.instance_variable_set(:@chips, 400)

    player.define_singleton_method :read_cli, lambda { 'c' }
    player.handle_push.should == :player_continue
    player.chips.should == 500
  end

  it 'should pay out 3:2 for blackjack wins' do
    player = Player.new
    player.instance_variable_set(:@bet, 100)
    player.instance_variable_set(:@chips, 400)
    player.hand = Hand.new
    player.hand << 1
    player.hand << 11

    player.define_singleton_method :read_cli, lambda { 'c' }
    player.handle_win.should == :player_continue
    player.chips.should == 650
  end
end
