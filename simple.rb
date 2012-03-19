require 'state_machine'

class Simple
  state_machine :state, :initial => :one do
    event :one_to_two do
      transition :one => :two
    end

    event :two_to_one do
      transition :two => :one
    end

    state :one do
      def command
        input = gets.strip
        if input == '2'
          :one_to_two
        end
      end
    end

    state :two do
      def command
        input = gets.strip
        if input == '1'
          :two_to_one
        end
      end
    end
  end

  def initialize
    super()
  end
end

sm = Simple.new

while true do
  puts 'get command'
  event = sm.command
  if event.nil?
    puts 'skipping invalid input'
    next
  end
  puts event
  sm.fire_state_event(event)
  puts 'fired'
end
