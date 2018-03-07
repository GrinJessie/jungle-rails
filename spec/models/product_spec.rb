require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'given all fields' do
      it 'should save successfully' do
        @category = Category.create({name: 'Food'})
        @product = Product.new({name: 'egg', price: 1, quantity: 50, category: @category})
        expect(@product.save).to be_truthy
      end
    end

    context 'without giving a name' do
      it 'should fail to save' do
        @category = Category.create({name: 'Food'})
        @product = Product.new({price: 1, quantity: 50, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include("Name can't be blank")

      end
    end

    context 'without giving a price' do
      it 'should fail to save' do
        @category = Category.create({name: 'Food'})
        @product = Product.new({name: 'egg', quantity: 50, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include("Price can't be blank")

      end
    end

    context 'without giving a quantity' do
      it 'should fail to save' do
        @category = Category.create({name: 'Food'})
        @product = Product.new({name: 'egg', price: 1, category: @category})
        @product.save
        expect(@product.errors.full_messages).to include("Quantity can't be blank")

      end
    end

    context 'without giving a category' do
      it 'should fail to save' do
        @product = Product.new({name: 'egg', price: 1, quantity: 50})
        @product.save
        expect(@product.errors.full_messages).to include("Category can't be blank")

      end
    end

  end
end
