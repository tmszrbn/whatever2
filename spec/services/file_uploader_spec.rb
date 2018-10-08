require 'rails_helper'

RSpec.describe FileUploader, type: :service do
  let(:csv_sample) { file_fixture('sample.csv') }
  let(:products_csv_file_uploader) { FileUploader.new ProductsInserter }
  describe '#upload' do
    it 'for csv file calls `CsvFormatter#format`' do
      expect(CsvFormatter).to receive(:format).with(csv_sample)
      products_csv_file_uploader.upload csv_sample
    end
    it 'for pdf does not call `CsvFormatter#format`' do
      expect(CsvFormatter).not_to receive(:format).with(csv_sample)
      FileUploader.new(ProductsInserter).upload 'sample.pdf'
    end
    it 'calls `@data_inserter.insert` with `@hash`' do
      data_inserter = products_csv_file_uploader.data_inserter
      expect(data_inserter).to receive(:insert)
      products_csv_file_uploader.upload csv_sample
    end
  end
end
