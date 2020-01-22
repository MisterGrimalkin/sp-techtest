require_relative '../classes/visits_report'

RSpec.describe VisitsReport do

  let(:url_one) { '/example/1' }
  let(:url_two) { '/example/2' }
  let(:url_three) { '/example/3' }
  let(:ip_one) { '10.0.0.1' }
  let(:ip_two) { '10.0.0.2' }
  let(:ip_three) { '10.0.0.3' }

  let(:counter) { VisitsCounter.new }

  subject { VisitsReport.new(counter) }

  context 'when no visits have occurred' do
    it 'returns no visits' do
      expect(subject.visits).to be_empty
    end
    it 'returns no unique visits' do
      expect(subject.unique_visits).to be_empty
    end
  end

  context 'when a single visit has occurred' do
    before {
      counter.visit(url_one, ip_one)
    }
    let(:expected_visits) {
      [{url_one => 1}]
    }
    let(:expected_unique_visits) {
      [{url_one => 1}]
    }
    it 'returns expected visit' do
      expect(subject.visits).to eq(expected_visits)
    end
    it 'returns expected unique visit' do
      expect(subject.unique_visits).to eq(expected_unique_visits)
    end
  end

  context 'when multiple visits have occurred' do
    before {
      counter.visit(url_one, ip_one)
      counter.visit(url_two, ip_one)
      counter.visit(url_two, ip_one)
      counter.visit(url_two, ip_two)
      counter.visit(url_two, ip_two)
      counter.visit(url_three, ip_one)
      counter.visit(url_three, ip_two)
      counter.visit(url_three, ip_three)
    }
    let(:expected_visits) {
      [{url_two => 4}, {url_three => 3}, {url_one => 1}]
    }
    let(:expected_unique_visits) {
      [{url_three => 3}, {url_two => 2}, {url_one => 1}]
    }
    it 'returns expected visit' do
      expect(subject.visits).to eq(expected_visits)
    end
    it 'returns expected unique visit' do
      expect(subject.unique_visits).to eq(expected_unique_visits)
    end
  end

end