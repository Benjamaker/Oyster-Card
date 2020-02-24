require "./lib/oyster.rb"

describe Oystercard do

  context '#balance' do

    it "can store a balance on it" do
      expect(subject).to have_attributes(balance: 0)
    end

  context '#top_up'

    it "can be topped up" do
      expect(subject).to respond_to(:top_up).with(1).argument
    end

    
  end
end
