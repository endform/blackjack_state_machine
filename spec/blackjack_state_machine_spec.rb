require 'spec_helper'

describe BlackjackStateMachine do
  it 'should give wins to blackjacks' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    # player has blackjack, dealer has 21
    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    player.hand << 1
    player.hand << 11
    dealer.hand << 4
    dealer.hand << 7
    dealer.hand << 10

    game.player_won?.should == true

    # dealer has blackjack, player 21
    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    dealer.hand << 1
    dealer.hand << 11
    player.hand << 4
    player.hand << 7
    player.hand << 10

    game.player_won?.should == false
  end

  it 'should not win or push when player busts' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    player.hand << 10
    player.hand << 11
    player.hand << 12
    dealer.hand << 2
    dealer.hand << 3

    game.player_won?.should == false
    game.player_push?.should == false
  end

  it 'should give win to player when dealer busts and player does not bust' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    dealer.hand << 10
    dealer.hand << 11
    dealer.hand << 12
    player.hand << 2
    player.hand << 3

    game.player_won?.should == true
  end

  it 'should give win to player when player score > dealer score' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    player.hand << 10
    player.hand << 11
    dealer.hand << 2
    dealer.hand << 3

    game.player_won?.should == true
  end

  it 'should push when player score equals dealer score and no blackjacks' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    player.hand << 3
    player.hand << 7
    dealer.hand << 4
    dealer.hand << 6

    game.player_won?.should == false
    game.player_push?.should == true
  end

  it 'should push when both dealer and player have blackjack' do
    game = BlackjackStateMachine.new
    player = Player.new
    dealer = Dealer.new(player)
    game.dealer = dealer
    game.player = player

    player.hand = Hand.new
    dealer.instance_variable_set(:@hand, Hand.new)

    player.hand << 1
    player.hand << 10
    dealer.hand << 14
    dealer.hand << 11

    game.player_won?.should == false
    game.player_push?.should == true
  end
end
