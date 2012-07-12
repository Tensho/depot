require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures :products

	test "product attributes must not be empty" do
		# свойства товара не должны оставаться пустыми
		product = Product.new
		assert product.invalid?
		assert product.errors[:title].any?
		assert product.errors[:description].any?
		assert product.errors[:price].any?
		assert product.errors[:image_url].any?
	end

	test "product price must be positive" do
		# цена товара должна быть положительной
		product = Product.new(title: 'Lorem Ipsum',
													description: 'Lorem Ipsum Description',
													image_url: 'lorem.jpg')
		product.price = -1
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",	product.errors[:price].join('; ')
		product.price = 0
		assert product.invalid?
		assert_equal "must be greater than or equal to 0.01",	product.errors[:price].join('; ')
		product.price = 1
		assert product.valid?
		# assert_equal "must be greater than or equal to 0.01",	product.errors[:price].join('; ')
	end

	def new_product(image_url)
		Product.new(title: 'Lorem Ipsum',
								description: 'Lorem Ipsum Description',
								image_url: image_url,
								price: 1)
	end

	test "product image url must be correct format" do
		# url изображения должен быть корректного формата
		ok = %w{ andrew.gif andrew.jpg andrew.png ANDREW.JPG http://example.com/andrew.gif }
		bad = %w{ andrew.doc andrew.gif/more andrew.gif.more }

		ok.each do |img_url|
			assert new_product(img_url).valid?, "#{img_url} shouldn't be invalid"
		end

		bad.each do |img_url|
			assert new_product(img_url).invalid?, "#{img_url} shouldn't be valid"
		end
	end

	test "product is not valid without a unique title" do
		# товар должен быть с уникальным названием
		product = Product.new(title: products(:kitty).title,
													description: 'some_description',
													image_url: 'some_image_url',
													price: 1)
		assert !product.save
		assert_equal "has already been taken", product.errors[:title].join('; ')
	end

	test "product title greater then or equal to 10 symbols" do
		ok_product = Product.new(title: 'Lorem Ipsum',
											description: 'Lorem Ipsum Description',
											image_url: 'lorem.jpg',
											price: 1)
		assert ok_product.valid?
		bad_product = Product.new(title: 'Lorem',
											description: 'Lorem Ipsum Description',
											image_url: 'lorem.jpg',
											price: 1)
		assert bad_product.invalid?
		assert_equal "10 characters is the minimum allowed",	bad_product.errors[:title].join('; ')
	end
end
