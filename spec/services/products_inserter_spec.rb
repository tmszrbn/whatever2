require 'rails_helper'

RSpec.describe ProductsInserter, type: :service do
  let(:shipping_category) { create :shipping_category } 
  let(:category1) { 'new_taxon1' }
  let(:product_attrs1) { attributes_for :base_product }
  let(:hash1) { { category: category1,
                  availability_date: product_attrs1[:available_on],
                  stock_total: 1,
                  name: product_attrs1[:name],
                  shipping_category_id: shipping_category.id,
                  price: product_attrs1[:price] } }
  let(:category2) { 'new_taxon2' }
  let(:product_attrs2) { attributes_for :base_product }
  let(:hash2) { { category: category2,
                  availability_date: product_attrs2[:available_on],
                  stock_total: 2,
                  name: product_attrs2[:name],
                  shipping_category_id: shipping_category.id,
                  price: product_attrs2[:price] } }
  let(:hashed_file) { [hash1, hash2] }
  let(:product1) { Spree::Product.first }
  let(:product2) { Spree::Product.second }
  let(:taxon1) { Spree::Taxon.first }
  let(:taxon2) { Spree::Taxon.second }
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
    # I know taxons were not the part of the task, but just for exercise
    it 'creates new taxons using hashes' do
      expect(taxon1.name).to eq category1
      expect(taxon2.name).to eq category2
    end
    it 'new taxons are associated with products' do
      expect(product1.taxons).to include taxon1
      expect(product2.taxons).to include taxon2
    end
  end
end
