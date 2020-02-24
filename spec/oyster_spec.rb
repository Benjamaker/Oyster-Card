require "./lib/oyster.rb"

describe Oystercard do

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

  context '#deduct' do

    it "can have money deducted" do
      expect(subject).to respond_to(:deduct).with(1).argument
    end

    it "deducts the given amount from balance" do
      subject.top_up(50)
      expect{subject.deduct(10)}.to change{subject.balance}.by -10
    end

  end

  context "journey" do

    it "can be in a journey" do
      expect(subject).to have_attributes(in_journey?: false)
    end

    it "can touch in to start a journey" do
      expect(subject).to respond_to(:touch_in)
    end

    it "can touch out to end a journey" do
      expect(subject).to respond_to(:touch_out)
    end

    it "changes #in_journey? status to true when touched in" do
      subject.top_up(10)
      subject.touch_in
      expect(subject).to be_in_journey
    end

    it "changes #in_journey? status to false when touched out" do
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect(subject).not_to be_in_journey
    end

  end

  context "#touch_in" do

    it "raises an error if there is insufficient balance for a minimum fare" do
      expect{subject.touch_in}.to raise_error "Insufficient balance. Please top up"
    end

  end





end
