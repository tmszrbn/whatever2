require 'rails_helper'

RSpec.describe UploadProductsJob, type: :job do
  describe '#perform' do
    let(:file_uploader) { instance_double('FileUploader') }

    it 'passes received arguments to `FileUploader#upload`' do
      allow(FileUploader).to receive(:new).and_return file_uploader
      expect(file_uploader).to receive(:upload)
      subject.perform(ProductsInserter)
    end
  end
end
