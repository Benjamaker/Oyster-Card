require 'journey'
require 'station'

describe Journey do

  # let(:stn_dbl) { double :station, zone: 1 }

  let(:entry_stn) { double(name: "liverpool st", zone: 1) }
  let(:exit_stn) { double(name: "tottenham court road", zone: 1) }

  it "has attributes entry_station and exit_station" do
    expect(subject).to have_attributes(entry_station: nil , exit_station: nil)
  end

  it "has a penalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  context '#start_journey' do

    it "responds to a method start_journey" do
      expect(subject).to respond_to(:start_journey).with(1).argument
    end

    it "updates entry station when start_journey method is called" do
      subject.start_journey(entry_stn)
      expect(subject.entry_station).to eq "liverpool st"
    end

  end

  context '#end_journey' do

    it "responds to a method end_journey" do
      expect(subject).to respond_to(:end_journey).with(1).argument
    end

    it "updates exit station when end_journey method is called" do
      subject.end_journey(exit_stn)
      expect(subject.exit_station).to eq "tottenham court road"
    end


  end

  context '#fare' do

    it "it responds to a fare method" do
      expect(subject).to respond_to(:fare)
    end
  end

    it "charges the minimum fare when journey is completed" do
      subject.start_journey(entry_stn)
      subject.end_journey(exit_stn)
      expect(subject.fare).to eq Journey::MIN_FARE
    end

  context '#complete?' do
    it "responds to a method complete?" do
      expect(subject).to respond_to(:complete?)
    end

    it "knows if a journey is not complete" do
      expect(subject).not_to be_complete
    end


  end


end
