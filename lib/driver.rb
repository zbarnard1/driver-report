class Driver

require_relative 'trip'

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def recordTrip(name, start_time, end_time, distance)
    trips << Trip.new(name, start_time, end_time, distance)
  end

  def reportStats(too_slow, too_fast)
    { name: @name,
      distance: calcDistance(too_slow, too_fast),
      mph: calcMph(too_slow, too_fast) }
  end

  private
  def trips
    @trips ||= []
  end

  def calcDistance(too_slow, too_fast)
    total = trips.inject(0) do |memo, trip|
      trip.mph.between?(too_slow, too_fast) ? memo + trip.distance : memo
    end
    total.round
  end

  def calcMph(too_slow, too_fast)
    sum = trips.inject(0) do |memo, trip|
      trip.mph.between?(too_slow, too_fast) ? memo + trip.mph : memo
    end
    trips.count != 0 ? (sum / trips.count).round : nil
  end
end