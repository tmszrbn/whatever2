class FileUploader

  attr_reader :data_inserter, :hash

  def initialize(data_inserter)
    @data_inserter = data_inserter
  end

  def upload(file)
    file_to_hash(file)
    hash_to_db
  rescue NameError => e
    e.message
  end

  private

  def file_to_hash(file)
    extension = "#{File.extname(file[:name])[1..-1].capitalize}Formatter"
    formatter = extension.constantize
    @hash = formatter.format(file[:body])
  end

  def hash_to_db
    data_inserter.insert(hash)
  end 
end
