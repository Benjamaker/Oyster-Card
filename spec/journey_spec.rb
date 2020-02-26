require 'journey'
require 'station'

describe Journey do

  it "has attributes entry_station and exit_station" do
    expect(subject).to have_attributes(entry_station: nil , exit_station: nil)
  end

  context '#start_journey' do

    it "responds to a method start_journey" do
      expect(subject).to respond_to(:start_journey)
    end


  end

  context '#end_journey' do

    it "responds to a method end_journey" do
      expect(subject).to respond_to(:end_journey)
    end


  end


end
