require_relative '../classes/visited_url.rb'

RSpec.describe VisitedUrl do

  let(:ip_one) { '10.0.0.1' }
  let(:ip_two) { '10.0.0.2' }
  let(:ip_three) { '10.0.0.3' }

  context 'when URL has not been visited' do
    it 'has no visits' do
      expect(subject.visits).to eq(0)
    end
    it 'has no unique visits' do
      expect(subject.unique_visits).to eq(0)
    end
  end

  context 'when URL is visited once' do
    before {
      subject.visit(ip_one)
    }
    it 'has 1 visit' do
      expect(subject.visits).to eq(1)
    end
    it 'has 1 unique visit' do
      expect(subject.unique_visits).to eq(1)
    end
  end

  context 'when URL is visited from 3 different IPs' do
    before {
      subject.visit(ip_one)
      subject.visit(ip_two)
      subject.visit(ip_three)
    }
    it 'has 3 visits' do
      expect(subject.visits).to eq(3)
    end
    it 'has 3 unique visits' do
      expect(subject.unique_visits).to eq(3)
    end
  end

  context 'when URL is visited 3 times from the same IP' do
    before {
      subject.visit(ip_one)
      subject.visit(ip_one)
      subject.visit(ip_one)
    }
    it 'has 3 visits' do
      expect(subject.visits).to eq(3)
    end
    it 'has 1 unique visit' do
      expect(subject.unique_visits).to eq(1)
    end
  end

  context 'when URL is visited multiple times from multiple IPs' do
    before {
      subject.visit(ip_one)
      subject.visit(ip_two)
      subject.visit(ip_two)
      subject.visit(ip_three)
      subject.visit(ip_three)
      subject.visit(ip_three)
    }
    it 'has 6 visits' do
      expect(subject.visits).to eq(6)
    end
    it 'has 3 unique visits' do
      expect(subject.unique_visits).to eq(3)
    end
  end

end