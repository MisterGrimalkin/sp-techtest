require_relative '../classes/visits_counter'

RSpec.describe VisitsCounter do

  let(:url_one) { '/example/1' }
  let(:url_two) { '/example/2' }
  let(:url_three) { '/example/3' }
  let(:ip_one) { '10.0.0.1' }
  let(:ip_two) { '10.0.0.2' }
  let(:ip_three) { '10.0.0.3' }

  context 'when no visits have occurred' do
    it 'returns no URLs' do
      expect(subject.urls).to be_empty
    end
  end

  context 'when a URL is visited once' do
    before {
      subject.visit(url_one, ip_one)
    }
    it 'returns 1 URL' do
      expect(subject.urls.size).to eq(1)
    end
    it 'logs 1 visit' do
      expect(subject.urls[url_one].visits).to eq(1)
    end
    it 'logs 1 unique visit' do
      expect(subject.urls[url_one].unique_visits).to eq(1)
    end
  end

  context 'when a URL is visited 3 times from a single IP' do
    before {
      subject.visit(url_one, ip_one)
      subject.visit(url_one, ip_one)
      subject.visit(url_one, ip_one)
    }
    it 'returns 1 URL' do
      expect(subject.urls.size).to eq(1)
    end
    it 'logs 3 visit' do
      expect(subject.urls[url_one].visits).to eq(3)
    end
    it 'logs 1 unique visit' do
      expect(subject.urls[url_one].unique_visits).to eq(1)
    end
  end

  context 'when a URL is visited 3 times from different IPs' do
    before {
      subject.visit(url_one, ip_one)
      subject.visit(url_one, ip_two)
      subject.visit(url_one, ip_three)
    }
    it 'returns 1 URL' do
      expect(subject.urls.size).to eq(1)
    end
    it 'logs 3 visit' do
      expect(subject.urls[url_one].visits).to eq(3)
    end
    it 'logs 3 unique visits' do
      expect(subject.urls[url_one].unique_visits).to eq(3)
    end
  end

  context 'when 3 URLs are visited from the same IP' do
    before {
      subject.visit(url_one, ip_one)
      subject.visit(url_two, ip_one)
      subject.visit(url_three, ip_one)
    }
    it 'returns 3 URLs' do
      expect(subject.urls.size).to eq(3)
    end
    it 'logs 1 visit to each URL' do
      expect(subject.urls[url_one].visits).to eq(1)
      expect(subject.urls[url_two].visits).to eq(1)
      expect(subject.urls[url_three].visits).to eq(1)
    end
    it 'logs 1 unique visit to each URL' do
      expect(subject.urls[url_one].unique_visits).to eq(1)
      expect(subject.urls[url_two].unique_visits).to eq(1)
      expect(subject.urls[url_three].unique_visits).to eq(1)
    end
  end

  context 'when 3 URLs are visited from multiple IPs' do
    before {
      subject.visit(url_one, ip_one)
      subject.visit(url_two, ip_one)
      subject.visit(url_two, ip_one)
      subject.visit(url_three, ip_one)
      subject.visit(url_three, ip_two)
      subject.visit(url_three, ip_three)
    }
    it 'returns 3 URLs' do
      expect(subject.urls.size).to eq(3)
    end
    it 'logs visits to each URL' do
      expect(subject.urls[url_one].visits).to eq(1)
      expect(subject.urls[url_two].visits).to eq(2)
      expect(subject.urls[url_three].visits).to eq(3)
    end
    it 'logs unique visits to each URL' do
      expect(subject.urls[url_one].unique_visits).to eq(1)
      expect(subject.urls[url_two].unique_visits).to eq(1)
      expect(subject.urls[url_three].unique_visits).to eq(3)
    end
  end

end