class ReportPrinter

  def print(heading, data)
    puts "#{heading}:"
    max_width = max_width(data)
    data.each do |entry|
      puts "#{entry.keys.first.ljust(max_width)} #{entry.values.first}"
    end
  end

  private

  def max_width(data)
    width = 0
    data.each do |entry|
      entry_width = entry.keys.first.size
      width = [width, entry_width].max
    end
    width
  end

end