require_relative 'classes/file_parser'
require_relative 'classes/report_printer'

if (filename = ARGV[0])

  parser = FileParser.new
  parser.parse(filename)

  printer = ReportPrinter.new
  printer.print('Visits', parser.report.visits)
  printer.print('Unique Visits', parser.report.unique_visits)
  unless parser.errors.empty?
    puts "Errors:\n#{parser.errors.join("\n")}"
  end

else
  puts "Usage: ./parser.rb [FILENAME]"
end

