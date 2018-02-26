RSpec.describe Trip do
  
  let (:trip) { Trip.new('Dan', '07:15', '07:45', '17.3') }

  it "has a driver" do
    expect(trip.driver).to eq('Dan')
  end

  it "has a distance" do
    expect(trip.distance).to eq(17)
  end

  it "calculates its duration" do
    expect(trip.send(:duration)).to eq(30*60)
  end

  it "calculates its mph" do
    expect(trip.mph).to eq(34)
  end

end