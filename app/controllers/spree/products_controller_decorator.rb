Spree::Admin::ProductsController.class_eval do
  def upload
    file = { name: params['file'].original_filename,
             body: params['file'].read }
    UploadProductsJob.perform_later(file)
  end
end
