require_relative 'station'

class Journey

  attr_reader :exit_station
  attr_accessor :entry_station

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize(entry_station = nil)
    @entry_station
    @exit_station
  end

  def start_journey(station)
    @entry_station = station.name
  end

  def end_journey(station)
    @exit_station = station.name
  end

  def fare
    @entry_station == nil ? PENALTY_FARE : MIN_FARE
  end

  def complete?

  end

end
