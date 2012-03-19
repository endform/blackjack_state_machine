class Player
  attr_reader :chips, :bet
  attr_accessor :hand

  def initialize
    @chips = 500
    @bet = 0
  end

  def add_chips(chips)
    @chips += chips
  end

  def read_cli
    gets.strip
  end

  def withdraw_money
    puts 'How much money would you like to withdraw?'
    amount = 0
    while amount === 0 do
      amount = read_cli.to_i
      if amount == 0
        puts 'Please enter a positive number value'
      else
        puts "Your childs college fund won't miss this"
      end
    end
    :player_withdrew_cash
  end

  def wager
    puts "How much would you like to bet? You have #{@chips} dollars in chips"
    amount = 0
    while amount == 0 do
      amount = read_cli.to_i

      if amount == 0
        puts 'Please enter a positive number value'
      elsif amount > 100
        puts 'Maximum bet is 100 chips'
        amount = 0
      elsif @chips - amount < 0
        puts 'Looks like you are trying to bet more than you have'
        amount = 0
      else
        @chips -= amount
        @bet = amount
      end
    end

    :player_placed_bet
  end

  def hit_or_stand
    puts "your hand: #{@hand}"
    puts 'Would you like to (h)it or (s)tand?'
    command = nil
    while command.nil? do
      command = read_cli[0].downcase
      case command
      when 'h'
        command = :player_hit
      when 's'
        command = :player_stood
      else
        puts 'Please enter s to stand or h to hit'
        command = nil
      end
    end
    command
  end

  def handle_loss
    puts 'So sorry, would you like to: (r)age quit or (d)eal with it'
    command = nil
    while command.nil? do
      command = read_cli[0].downcase
      case command
      when 'r'
        command = :rage_quit
      when 'd'
        command = :player_wants_more
      else
        puts 'Please enter r to rage quit or d to deal with it and continue'
      end
    end
  end
end
