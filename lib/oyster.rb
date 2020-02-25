class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_reader :balance
  attr_reader :journeys

  def initialize
    @balance = 0
    @journeys = []
  end

  def top_up(money)
    check_max_balance(money)
    @balance += money
    success_message
  end

  def in_journey?
    @journeys.any? && @journeys.last.value?(nil)
  end

  def touch_in(entry_station)
    check_min_balance
    @journeys << { entry_station => nil }
  end

  def touch_out(exit_station)
    deduct(MIN_FARE)
    @journeys.last.transform_values! { exit_station }
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
