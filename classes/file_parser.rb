require_relative 'visits_counter'
require_relative 'visits_report'

class FileParser

  def initialize
    @counter = VisitsCounter.new
    @errors = []
  end

  def report
    VisitsReport.new(@counter)
  end

  attr_reader :errors

  def parse(filename)
    File.open(filename, 'r').each_line.with_index do |line, number|
      begin
        process_line(line)
      rescue BadDataError => e
        @errors << "#{e.message} on line #{number+1}"
      end
    end
  end

  private

  def process_line(line)
    split = line.split(' ')
    if split.size == 2
      # TODO: URL and IP address validation
      @counter.visit(split[0], split[1])
    else
      raise BadDataError.new('Bad data')
    end
  end

end

class BadDataError < StandardError; end
