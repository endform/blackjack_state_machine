require 'rubygems'
require 'state_machine'

require './player'
require './dealer'

class Blackjack
  attr_accessor :player, :dealer

  def initialize
    @player = Player.new
    @dealer = Dealer.new(@player)
    super() #initializes states
  end

  state_machine :state, :initial => :wagering do
    after_transition :on => :player_hit, :do => lambda { |game|
      game.dealer.hit_player
    }

    # events
    event :player_placed_bet do
      transition :wagering => :dealing
    end

    event :dealt do
      transition :dealing => :player_turn
    end

    event :player_hit do
      transition :player_turn => :player_turn, :unless => lambda { |game|
        game.player.hand.bust?
      }
      transition :player_turn => :loss
    end

    event :player_stood do
      transition :player_turn => :dealer_turn
    end

    event :dealer_hit do
      transition :dealer_turn => :dealer_turn, :if => lambda {|x| true}
      transition :dealer_turn => :win
    end

    event :dealer_stood do
      transition :dealer_turn => :win, :if => lambda {|x| true}
      transition :dealer_turn => :loss
    end

    event :player_withdrew_cash do
      transition :atm => :wagering
    end

    event :player_wants_more do
      transition :loss => :wagering, :if => lambda { |game|
        game.player.chips > 0
      }
      transition :loss => :atm
    end

    event :rage_quit do
      transition :loss => :quit
    end

    # states
    state :atm do
      def command
        @player.withdraw_money
      end
    end

    state :dealing do
      def command
        @dealer.deal
        :dealt
      end
    end

    state :wagering do
      def command
        @player.wager
      end
    end

    state :player_turn do
      def command
        player.hit_or_stand
      end
    end

    state :dealer_turn do
      def command
      end
    end

    state :loss do
      def command
        player.handle_loss
      end
    end

    state :win do
      def command
      end
    end

    state :quit do
      def command
        exit
      end
    end
  end
end

#StateMachine::Machine.draw('Blackjack')

game = Blackjack.new

while true do
  puts game.state
  event = game.command
  game.fire_state_event(event) unless event.nil?
end
