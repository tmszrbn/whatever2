require 'rails_helper'

RSpec.describe 'products management', type: :request do
  let(:admin) { create :admin_user }
  
  describe '#upload' do
    context 'signed in as an admin' do
      before :each do 
        sign_in admin
      end
      it 'imports file to database' do
        path = '/some/path/to/file'
        expect(UploadProductsJob).to receive(:perform_now).with(path)
        post spree.upload_admin_products_path, params: { file_path: path }
      end
    end
  end
end
