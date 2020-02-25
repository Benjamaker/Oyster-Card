require "./lib/oyster.rb"

describe Oystercard do

  let(:entry_dbl) { double("Station", name: "entry_stn") }
  let(:exit_dbl) { double("Station", name: "exit_stn") }

  context '#balance' do

    it "can store a balance on it" do
      expect(subject).to have_attributes(balance: 0)
    end

  end

  context '#top_up' do

    it "can be topped up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    it "tops up the balance by the given amount" do
      expect{subject.top_up(3)}.to change{subject.balance}.by 3
    end

    it "raises an error if top up exceeds maximum balance" do
      expect{subject.top_up(91)}.to raise_error("Top up exceeds maximum balance of 90")
    end

    it "gives the user a message confirming a succesful top up" do
      expect(subject.top_up(50)).to eq "Top up succesful. Your new balance is #{subject.balance}"
    end

  end

#REMOVED THESE TESTS AS MADE DEDUCT METHOD PRIVATE
  # context '#deduct' do
  #
  #   it "can have money deducted" do
  #     expect(subject).to respond_to(:deduct).with(1).argument
  #   end
  #
  #   it "deducts the given amount from balance" do
  #     subject.top_up(50)
  #     expect{subject.deduct(10)}.to change{subject.balance}.by -10
  #   end
  #
  # end

  context "journey" do

    it "can be in a journey" do
      expect(subject).to have_attributes(in_journey?: false)
    end

    it "has attribute journeys" do
      expect(subject).to have_attributes(journeys: [])
    end

    it "can touch in to start a journey" do
      expect(subject).to respond_to(:touch_in).with(1).argument
    end

    it "can touch out to end a journey" do
      expect(subject).to respond_to(:touch_out).with(1).argument
    end

    it "changes #in_journey? status to true when touched in" do
      subject.top_up(10)
      #subject.touch_in(entry_dbl)
      expect(subject.tap{|s|s.touch_in(entry_dbl)}).to be_in_journey
    end

    it "status of #in_journey stays true if already touched in" do
      subject.top_up(10)
      subject.touch_in(entry_dbl)
      expect{subject.touch_in(entry_dbl)}.not_to change{subject.in_journey?}
    end

    it "changes #in_journey? status to false when touched out" do
      subject.top_up(10)
      subject.touch_in(entry_dbl)
      subject.touch_out(exit_dbl)
      expect(subject).not_to be_in_journey
    end

    # it "status of #in_journey stays false if already touched out" do
    #   subject.top_up(10)
    #   subject.touch_out(exit_dbl)
    #   expect{subject.touch_out(exit_dbl)}.not_to change{subject.in_journey?}
    # end

    it "has an empty list of journeys by default" do
      expect(subject.journeys).to be_empty
    end

    it "stores a single journey when touching in and out" do
      subject.top_up(10)
      subject.touch_in(entry_dbl)
      subject.touch_out(exit_dbl)
      expect(subject.journeys.length).to eq 1
    end

    it "shouldn't have an exit station when touched in but not out" do
      subject.top_up(10)
      subject.touch_in(entry_dbl)
      expect(subject.journeys.last.value?(nil)).to be(true)
    end

  end

  context "#touch_in(entry_dbl)" do

    it "raises an error if there is insufficient balance for a minimum fare" do
      expect{subject.touch_in(entry_dbl)}.to raise_error "Insufficient balance. Please top up"
    end

    # it "remembers the station when touching in" do
    #   subject.top_up(10)
    #   subject.touch_in(entry_dbl)
    #   expect(subject.entry_station).to eq(entry_dbl)
    # end

  end

  context "#touch_out(exit_dbl)" do

    it "responds to #deduct" do
      expect(subject).to respond_to(:touch_out)
    end

    it "reduces balance by the correct amount" do
      subject.top_up(10)
      subject.touch_in(entry_dbl)
      expect{subject.touch_out(exit_dbl)}.to change{subject.balance}.by -1
    end

    # it "forgets entry_station when touched out" do
    #   subject.top_up(10)
    #   subject.touch_in(entry_dbl)
    #   subject.touch_out(exit_dbl)
    #   expect(subject.entry_station).to eq nil
    # end
  end


end
