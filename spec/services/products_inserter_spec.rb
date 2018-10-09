require 'rails_helper'

RSpec.describe ProductsInserter, type: :service do
  let(:product_attrs1) { attributes_for :base_product }
  let(:category1) { 'new_category1' }
  let(:hash1) { { available_on: product_attrs1[:available_on],
                  name: product_attrs1[:name],
                  category: category1,
                  price: product_attrs1[:price] } }
  let(:category2) { 'new_category2' }
  let(:product_attrs2) { attributes_for :base_product }
  let(:hash2) { { available_on: product_attrs2[:available_on],
                  name: product_attrs2[:name],
                  category: category2,
                  price: product_attrs2[:price] } }
  let(:hashed_file) { [hash1.stringify_keys, hash2.stringify_keys] }
  let(:product1) { Spree::Product.first }
  let(:product2) { Spree::Product.second }
  let(:shipping_category1) { Spree::ShippingCategory.first }
  let(:shipping_category2) { Spree::ShippingCategory.second }
  let(:variant1) { Spree::Variant.first }
  let(:variant2) { Spree::Variant.second }
  describe '.insert' do
    before :each do
      ProductsInserter.insert hashed_file
    end
    it 'creates new products using hashes' do
      expect(Spree::Product.count).to eq(hashed_file.count)
    end
    it 'creates master variants for products' do
      expect(product1.master).to eq variant1
      expect(product2.master).to eq variant2
    end
    it 'creates new taxons using hashes' do
      expect(shipping_category1.name).to eq category1
      expect(shipping_category2.name).to eq category2
    end
    it 'new taxons are associated with products' do
      expect(product1.shipping_category).to eq shipping_category1
      expect(product2.shipping_category).to eq shipping_category2
    end
  end
end
