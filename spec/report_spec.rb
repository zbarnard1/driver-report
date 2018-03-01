RSpec.describe Report do

  let(:report) { Report.new() }
  
  let(:generated_report) {"Cindy: 125 miles @ 40 mph\nTinisha: 17 miles @ 34 mph\nChristoph: 0 miles\n"}


  it "creates a list of Drivers" do
    report.new_driver('David')

    expect(report.drivers['David'][:driver]).to be_an_instance_of(Driver)
  end

  it "passes the trip information to the correct Driver" do
    report.new_driver('Bob')
    report.new_driver('Marlena')

    expect{report.interpret('Trip Bob 11:00 11:30 17.5')}
    .to change{report.drivers['Bob'][:driver].send(:trips).count}.by(1)

    expect{report.interpret('Trip Bob 11:00 11:30 17.5')}
    .not_to change{report.drivers['Marlena'][:driver].send(:trips).count}
  end

  it "gets data from each of its Drivers" do
    report.new_driver('Mike')
    report.new_driver('Pedro')
    allow(report.drivers['Mike'][:driver]).to receive(:report_stats)
    allow(report.drivers['Pedro'][:driver]).to receive(:report_stats)

    report.get_data

    expect(report.drivers['Mike'][:driver]).to have_received(:report_stats).with(5, 100)
    expect(report.drivers['Pedro'][:driver]).to have_received(:report_stats).with(5, 100)
  end

  it "sorts the data by miles driven" do
    report.new_driver('Jimmy')
    report.new_driver('Clara')
    report.drivers['Jimmy'][:driver].record_trip('Jimmy', '10:00', '11:00', '35')
    report.drivers['Clara'][:driver].record_trip('Clara', '12:00', '14:00', '90')

    report.get_data
    report.sort_drivers

    expect(report.driver_data[0][:name]).to eq('Clara')
    expect(report.driver_data[1][:name]).to eq('Jimmy')
  end

  it "generates and prints a report" do
    report.new_driver('Christoph')
    report.new_driver('Cindy')
    report.new_driver('Tinisha')
    report.drivers['Cindy'][:driver].record_trip('Cindy', '10:00', '11:00', '35')
    report.drivers['Cindy'][:driver].record_trip('Cindy', '12:00', '14:00', '90')
    report.drivers['Tinisha'][:driver].record_trip('Tinisha', '11:00', '11:30', '17.5')

    expect{report.generate_report}.to output(generated_report).to_stdout
  end
end