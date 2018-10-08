class ProductsInserter
  def self.insert hashes_array
    hashes_array.map do |hash|
      category = hash.delete(:category)
      taxon = Spree::Taxon.find_or_create_by(name: category)
      product = create_product hash
      product.taxons << taxon
    end
  end

  def self.create_product hash
    hash.delete(:stock_total)
    hash[:available_on] = hash.delete(:availability_date)
    Spree::Product.create hash
  end

  private_class_method :create_product
end
