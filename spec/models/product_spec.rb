require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save successfully when not missing name, price, quantity, and category' do
      @category = Category.new(name: 'test')

      @product = Product.new(name: 'Pen', price: 100, quantity: 10, category: @category)
      @product.save!

      expect(@product.id).to be_present
    end
    
    it 'should not save when missing a name'do
      @category = Category.new(name: 'test')

      @product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
      @product.save

      expect(@product.id).not_to be_present
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should not save when missing a price'do
      @category = Category.new(name: 'test')

      @product = Product.new(name: 'Pen', price: nil, quantity: 10, category: @category)
      @product.save

      expect(@product.id).not_to be_present
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should not save when missing a quantity'do
      @category = Category.new(name: 'test')

      @product = Product.new(name: 'Pen', price: 100, quantity: nil, category: @category)
      @product.save

      expect(@product.id).not_to be_present
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should not save when missing a category'do
      @product = Product.new(name: 'Pen', price: 100, quantity: 10, category: nil)
      @product.save

      expect(@product.id).not_to be_present
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
