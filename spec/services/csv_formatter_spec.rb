require 'rails_helper'

RSpec.describe CsvFormatter, type: :service do
  let(:csv) { file_fixture('sample.csv') }
  describe '.format' do
    it 'reads the file and returns an array' do
      expect(CsvFormatter.format(csv).class).to eq Array 
    end
    it 'hashes do not contain nil keys' do
      expect(CsvFormatter.format(csv)[0].keys.include? nil).to be false
    end
  end
end
