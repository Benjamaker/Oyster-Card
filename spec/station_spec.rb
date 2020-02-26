require 'station'

describe Station do
  it 'checks the station has name and zone attributes' do
    expect(subject).to have_attributes(name: nil, zone: nil)
  end


end
