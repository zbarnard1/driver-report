#!/usr/bin/env ruby

require_relative './report.rb'
require_relative './driver.rb'
require_relative './trip.rb'

report = Report.new
ARGF.each { |line| report.interpret(line)  }
report.generate_report