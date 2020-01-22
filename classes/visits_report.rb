class VisitsReport

  def initialize(counter)
    @counter = counter
  end

  def visits
    collate(:visits)
  end

  def unique_visits
    collate(:unique_visits)
  end

  private

  def collate(method)
    @counter.urls.sort_by{|_, data| data.send(method) }.reverse.collect do |url, data|
      {url => data.send(method)}
    end
  end

end