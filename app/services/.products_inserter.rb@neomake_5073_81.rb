class ProductsInserter
  def self.insert hashes_array
    hashes_array.map do |hash|
      category = hash.delete('category')
      shipping_category = Spree::ShippingCategory.find_or_create_by(name: category)
      product = create_product hash, shipping_category
    end
  end

  def self.create_product hash, shipping_category
    hash.delete('stock_total')
    hash['available_on'] = hash.delete('availability_date')
    p = Spree::Product.create hash.merge(shipping_category_id: shipping_category.id)
  end

  private_class_method :create_product
end
