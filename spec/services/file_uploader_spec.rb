require 'rails_helper'

RSpec.describe FileUploader, type: :service do
  let(:csv_sample) { { name: 'sample.csv',
                       body: file_fixture('sample.csv').read } }
  let(:pdf_sample) { { name: 'sample.pdf',
                       body: file_fixture('sample.csv').read } }
  let(:products_csv_file_uploader) { FileUploader.new ProductsInserter }
  describe '#upload' do
    it 'for csv file calls `CsvFormatter#format`' do
      expect(CsvFormatter).to receive(:format).with csv_sample[:body]
      products_csv_file_uploader.upload csv_sample
    end
    it 'for pdf does not call `CsvFormatter#format`' do
      expect(CsvFormatter).not_to receive(:format)
      FileUploader.new(ProductsInserter).upload pdf_sample
    end
    it 'calls `@data_inserter.insert` with `@hash`' do
      data_inserter = products_csv_file_uploader.data_inserter
      expect(data_inserter).to receive(:insert)
      products_csv_file_uploader.upload csv_sample
    end
  end
end
