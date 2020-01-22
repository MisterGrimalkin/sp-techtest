require_relative '../classes/report_printer'

RSpec.describe ReportPrinter do

  let(:data) {
    [{'/home' => 3}, {'/about_us' => 2}]
  }

  let(:expected_output) {
    "Visits:\n/home     3\n/about_us 2\n"
  }

  it 'prints report correctly' do
    output = ''
    allow(subject).to receive(:puts) do |value|
      output << "#{value}\n"
    end
    subject.print('Visits', data)
    expect(output).to eq(expected_output)
  end


end