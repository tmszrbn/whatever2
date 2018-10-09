require 'rails_helper'

RSpec.describe 'products management', type: :request do
  let(:admin) { create :admin_user }
  let(:csv) { fixture_file_upload('files/sample.csv') }

  describe '#upload' do
    context 'signed in as an admin' do
      before :each do 
        sign_in admin
      end
      it 'uploads file by using the `UploadProductsJob.perform_later`' do
        expect(UploadProductsJob).to receive(:perform_later)
        post spree.upload_admin_products_path, params: { file: csv }
      end
    end
  end
end
