class UploadProductsJob < ApplicationJob
  queue_as :default

  def perform(file, data_inserter)
    FileUploader.new(data_inserter).upload(file)
  end
end
