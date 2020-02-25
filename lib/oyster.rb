class Oystercard

  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 1

  attr_reader :balance
  attr_reader :entry_station

  def initialize
    @balance = 0
    @entry_station = nil
  end

  def top_up(money)
    check_max_balance(money)
    @balance += money
    success_message
  end

  def in_journey?
    @entry_station == nil ? false : true
  end

  def touch_in(station)
    check_min_balance
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @entry_station = nil
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
