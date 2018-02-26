class Report

  TOO_SLOW = 5
  TOO_FAST = 100

  def initialize
  end

  def interpret(line)
    splitLine = line.split
    if splitLine.first == 'Driver'
      splitLine.shift
      newDriver(*splitLine)
    elsif splitLine.first == 'Trip'
      splitLine.shift
      drivers[splitLine.first][:driver].recordTrip(*splitLine)
    end
  end

  def getData
    drivers.keys.each do |key|
      result = drivers[key][:driver].reportStats(TOO_SLOW, TOO_FAST)
      driverData << result
    end
  end

  def sortDrivers
    driverData.sort! { |a, b| a[:distance] <=> b[:distance] }
    driverData.reverse!
  end

  def generateReport
    formattedOutput = ""
    self.getData
    sortDrivers
    driverData.each do |data|
        formattedOutput << "#{data[:name]}: #{data[:distance]} miles"
      if data[:distance] != 0
        formattedOutput << " @ #{data[:mph]} mph"
      end
        formattedOutput << "\n"
    end
     puts formattedOutput
  end

  def newDriver(name)
    drivers[name] = { driver: Driver.new(name) }
  end

  def drivers
    @drivers ||= {}
  end

  def driverData
    @driverData ||= []
  end

end