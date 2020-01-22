require_relative 'visited_url'

class VisitsCounter

  def initialize
    @urls = {}
  end

  attr_reader :urls

  def visit(url, remote_ip)
    unless (target = @urls[url])
      target = @urls[url] = VisitedUrl.new
    end
    target.visit(remote_ip)
  end

end