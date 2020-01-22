class VisitedUrl

  def initialize
    @visits = 0
    @unique_visitors = []
  end

  def visit(remote_ip)
    @visits += 1
    @unique_visitors << remote_ip unless @unique_visitors.include?(remote_ip)
  end

  attr_reader :visits

  def unique_visits
    @unique_visitors.size
  end

end