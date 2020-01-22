require_relative '../classes/file_parser'

RSpec.describe FileParser do

  let(:url_one) { '/example/1' }
  let(:url_two) { '/example/2' }
  let(:ip_one) { '10.0.0.1' }
  let(:ip_two) { '10.0.0.2' }

  context 'when given valid data' do
    let(:data) {
      StringIO.new("#{url_one} #{ip_one}\n#{url_two} #{ip_one}\n#{url_two} #{ip_two}\n#{url_two} #{ip_two}"   )
    }
    let(:expected_visits) {
      [{url_two => 3}, {url_one => 1}]
    }
    let(:expected_unique_visits) {
      [{url_two => 2}, {url_one => 1}]
    }
    before {
      allow(File).to receive(:open).and_return(data)
      subject.parse('somefile.log')
    }
    it 'returns no errors' do
      expect(subject.errors).to be_empty
    end
    it 'returns visits' do
      expect(subject.report.visits).to eq(expected_visits)
    end
    it 'returns unique visits' do
      expect(subject.report.unique_visits).to eq(expected_unique_visits)
    end
  end

  context 'when given malformed data' do
    let(:data) {
      StringIO.new("#{url_one} #{url_one} #{ip_one}\n#{url_one}\n#{url_one} #{ip_one}")
    }
    let(:expected_errors) {
      ['Bad data on line 1', 'Bad data on line 2']
    }
    let(:expected_visits) {
      [{url_one => 1}]
    }
    let(:expected_unique_visits) {
      [{url_one => 1}]
    }
    before {
      allow(File).to receive(:open).and_return(data)
      subject.parse('somefile.log')
    }
    it 'returns errors' do
      expect(subject.errors).to eq(expected_errors)
    end
    it 'returns visits' do
      expect(subject.report.visits).to eq(expected_visits)
    end
    it 'returns unique visits' do
      expect(subject.report.unique_visits).to eq(expected_unique_visits)
    end
  end

end