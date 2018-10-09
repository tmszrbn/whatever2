class UploadProductsJob < ActiveJob::Base
  queue_as :default

  rescue_from TypeError do |exception|
  end

  def perform(file)
    FileUploader.new(ProductsInserter).upload(file)
  end
end
