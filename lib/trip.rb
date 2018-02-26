class Trip

  require 'time'

  attr_reader :driver, :distance

  def initialize(driver, start_time, end_time, distance)
    @driver = driver
    @start_time = Time.parse(start_time)
    @end_time = Time.parse(end_time)
    @distance = distance.to_i
  end

  def mph
    distance / (duration/3600) 
  end

  private
  def duration
    @end_time - @start_time
  end

end