require 'state_machine'

require 'player'
require 'dealer'

class BlackjackStateMachine
  attr_accessor :player, :dealer

  def initialize
    @player = Player.new
    @dealer = Dealer.new(@player)
    super() #initializes states
  end

  state_machine :state, :initial => :wagering do
    after_transition :on => :player_stood, :do => lambda { |game|
      puts "Player stood with hand #{game.player.hand}"
      puts "Which gets a score of #{game.player.hand.optimal_score}"
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
        game.dealer.hit_player
        game.player.hand.bust?
      }
      transition :player_turn => :loss
    end

    event :player_stood do
      transition :player_turn => :dealer_turn
    end

    event :dealer_finished do
      transition :dealer_turn => :win, :if => lambda { |game|
        dealer_score = game.dealer.hand.optimal_score
        player_score = game.player.hand.optimal_score
        game.dealer.hand.bust? || dealer_score < player_score
      }
      transition :dealer_turn => :push, :if => lambda { |game|
        dealer_score = game.dealer.hand.optimal_score
        player_score = game.player.hand.optimal_score
        dealer_score == player_score
      }
      transition :dealer_turn => :loss
    end

    event :player_withdrew_cash do
      transition :atm => :wagering
    end

    event :player_continue do
      transition [:win, :push] => :wagering
      transition :loss => :wagering, :if => lambda { |game|
        game.player.chips > 0
      }
      transition :loss => :atm
    end

    event :player_quit do
      transition [:win, :push, :loss] => :quit
    end

    # states
    state :atm do
      def command
        player.withdraw_money
      end
    end

    state :dealing do
      def command
        dealer.deal
      end
    end

    state :wagering do
      def command
        player.wager
      end
    end

    state :player_turn do
      def command
        player.hit_or_stand
      end
    end

    state :dealer_turn do
      def command
        dealer.dealer_play
      end
    end

    state :loss do
      def command
        player.handle_loss
      end
    end

    state :win do
      def command
        player.handle_win
      end
    end

    state :push do
      def command
        player.handle_push
      end
    end

    state :quit do
      def command
        exit
      end
    end
  end
end
