Spree::Admin::ProductsController.class_eval do
  def upload
    UploadProductsJob.perform_now(params[:file_path])
  end
end
