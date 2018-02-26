RSpec.describe Report do

  let(:report) { Report.new() }
  
  let(:generatedReport) {"Cindy: 125 miles @ 40 mph\nTinisha: 17 miles @ 34 mph\nChristoph: 0 miles\n"}


  it "creates a list of Drivers" do
    report.newDriver('David')

    expect(report.drivers['David'][:driver]).to be_an_instance_of(Driver)
  end

  it "passes the trip information to the correct Driver" do
    report.newDriver('Bob')
    report.newDriver('Marlena')

    expect{report.interpret('Trip Bob 11:00 11:30 17.5')}
    .to change{report.drivers['Bob'][:driver].send(:trips).count}.by(1)

    expect{report.interpret('Trip Bob 11:00 11:30 17.5')}
    .not_to change{report.drivers['Marlena'][:driver].send(:trips).count}
  end

  it "gets data from each of its Drivers" do
    report.newDriver('Mike')
    report.newDriver('Pedro')
    allow(report.drivers['Mike'][:driver]).to receive(:reportStats)
    allow(report.drivers['Pedro'][:driver]).to receive(:reportStats)

    report.getData

    expect(report.drivers['Mike'][:driver]).to have_received(:reportStats).with(5, 100)
    expect(report.drivers['Pedro'][:driver]).to have_received(:reportStats).with(5, 100)
  end

  it "sorts the data by miles driven" do
    report.newDriver('Jimmy')
    report.newDriver('Clara')
    report.drivers['Jimmy'][:driver].recordTrip('Jimmy', '10:00', '11:00', '35')
    report.drivers['Clara'][:driver].recordTrip('Clara', '12:00', '14:00', '90')

    report.getData
    report.sortDrivers

    expect(report.driverData[0][:name]).to eq('Clara')
    expect(report.driverData[1][:name]).to eq('Jimmy')
  end

  it "generates and prints a report" do
    report.newDriver('Christoph')
    report.newDriver('Cindy')
    report.newDriver('Tinisha')
    report.drivers['Cindy'][:driver].recordTrip('Cindy', '10:00', '11:00', '35')
    report.drivers['Cindy'][:driver].recordTrip('Cindy', '12:00', '14:00', '90')
    report.drivers['Tinisha'][:driver].recordTrip('Tinisha', '11:00', '11:30', '17.5')

    expect{report.generateReport}.to output(generatedReport).to_stdout
  end
  
end