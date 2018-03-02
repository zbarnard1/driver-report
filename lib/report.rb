class Report

  TOO_SLOW = 5
  TOO_FAST = 100

  def initialize
  end

  def interpret(line)
    split_line = line.split
    if split_line.first == 'Driver'
      split_line.shift
      new_driver(*split_line)
    elsif split_line.first == 'Trip'
      split_line.shift
      drivers[split_line.first].record_trip(*split_line)
    end
  end

  def generate_report
    get_data
    sort_drivers
    create_output
  end

  def drivers
    @drivers ||= {}
  end

  def driver_data
    @driver_data ||= []
  end

  private
  def get_data
    drivers.keys.each do |key|
      result = drivers[key].report_stats(TOO_SLOW, TOO_FAST)
      driver_data << result
    end
  end

  def sort_drivers
    driver_data.sort! { |a, b| a[:distance] <=> b[:distance] }
    driver_data.reverse!
  end

  def create_output
    output = ""
    driver_data.each do |data|
      output << "#{data[:name]}: #{data[:distance]} miles"
      data[:distance] != 0 ? output << " @ #{data[:mph]} mph" : nil
      output << "\n"
    end
     puts output
  end

  def new_driver(name)
    drivers[name] =  Driver.new(name)
  end
end