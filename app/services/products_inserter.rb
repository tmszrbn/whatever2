class ProductsInserter
  def self.insert hashes_array
    hashes_array.map do |hash|
      hash = hash.stringify_keys
      category = hash.delete('category')
      shipping_category = Spree::ShippingCategory.find_or_create_by(name: category)
      hash['shipping_category_id'] = shipping_category.id
      product = create_product hash
    end
  end

  def self.create_product hash
    hash.delete('stock_total')
    hash['available_on'] = hash.delete('availability_date')
    p = Spree::Product.create hash
  end

  private_class_method :create_product
end
