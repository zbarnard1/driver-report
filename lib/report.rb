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
      drivers[split_line.first][:driver].record_trip(*split_line)
    end
  end

  def get_data
    drivers.keys.each do |key|
      result = drivers[key][:driver].report_stats(TOO_SLOW, TOO_FAST)
      driver_data << result
    end
  end

  def sort_drivers
    driver_data.sort! { |a, b| a[:distance] <=> b[:distance] }
    driver_data.reverse!
  end

  def generate_report
    formatted_output = ""
    get_data
    sort_drivers
    driver_data.each do |data|
        formatted_output << "#{data[:name]}: #{data[:distance]} miles"
      if data[:distance] != 0
        formatted_output << " @ #{data[:mph]} mph"
      end
        formatted_output << "\n"
    end
     puts formatted_output
  end

  def new_driver(name)
    drivers[name] = { driver: Driver.new(name) }
  end

  def drivers
    @drivers ||= {}
  end

  def driver_data
    @driver_data ||= []
  end
end