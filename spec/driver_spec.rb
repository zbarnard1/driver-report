RSpec.describe Driver do

  let (:driver) { Driver.new('Priyang') }
  before do
    driver.recordTrip('Priyang', '12:01', '13:16', 42.0)
    driver.recordTrip('Priyang', '10:01', '11:05', 36.2)
  end

  it "initializes the trips it owns" do
    expect(driver.send(:trips).count).to eq(2)
  end

  it "calculates its distance driven" do
    expect(driver.send(:calcDistance, 5, 100)).to eq(78)
  end

  it "calculates its average mph" do
    expect(driver.send(:calcMph, 5, 100)).to eq(34)
  end

  it "discards trips that are outliers" do
    driver.recordTrip('Priyang', '00:00', '01:00', 1000)
    driver.recordTrip('Priyang', '00:00', '01:00', 1)
    expect(driver.send(:calcDistance, 5, 100)).to eq(78)
  end
  
  it "responds with its distance driven and mph" do
    expect(driver.reportStats(5, 100)).to eq({name: 'Priyang', distance: 78, mph: 34})
  end
end