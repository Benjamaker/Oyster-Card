class Oystercard

  MAX_BALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
    @status = false
  end

  def top_up(money)
    check_max_balance(money)
    @balance += money
    success_message
  end

  def deduct(money)
    @balance -= money
  end

  def in_journey?
    @status
  end

  def touch_in
  end

  def touch_out
  end    

  private

  def check_max_balance(money)
    raise "Top up exceeds maximum balance of #{MAX_BALANCE}" if (@balance + money) > MAX_BALANCE
  end

  def success_message
    "Top up succesful. Your new balance is #{@balance}"
  end

end
