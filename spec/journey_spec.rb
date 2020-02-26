require 'journey'
require 'station'

describe Journey do

  it "has attributes entry_station and exit_station" do
    expect(subject).to have_attributes(entry_station: nil , exit_station: nil)
  end

  



end
