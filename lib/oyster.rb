require_relative 'journey'
require_relative 'station'

class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1

  attr_reader :balance
  attr_reader :journeys
  attr_reader :journey

  def initialize
    @balance = 0
    @journey = Journey.new
    @journeys = []
    # @current_journey = nil
  end

  def top_up(money)
    check_max_balance(money)
    @balance += money
    success_message
  end

  # def in_journey?
  #   @journeys.any? && @journeys.last.value?(nil)
  # end

  def touch_in(station)
    check_min_balance
    @journey.start_journey(station)
    @journeys << { station => nil }
  end

  def touch_out(station)
    deduct(@journey.fare)
    @journey.end_journey(station)
    @journeys.last.transform_values! { station }
  end


  private

  def deduct(money)
    @balance -= money
  end

  def check_max_balance(money)
    raise "Top up exceeds maximum balance of #{MAX_BALANCE}" if (@balance + money) > MAX_BALANCE
  end

  def check_min_balance
    raise "Insufficient balance. Please top up" if @balance < MIN_BALANCE
  end

  def success_message
    "Top up succesful. Your new balance is #{@balance}"
  end

end
