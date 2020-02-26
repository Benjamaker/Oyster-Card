require 'station'

describe Station do

subject { described_class.new("old street", 1) }

  it "knows its name" do
    expect(subject.name).to eq("old street")
  end

  it "knows it's zone" do
    expect(subject.zone).to eq(1)
  end


end
