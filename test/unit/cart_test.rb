require 'test_helper'
 
class CartTest < ActiveSupport::TestCase
  test "add unique products" do
    # добавление уникального продукта в корзину
    cart = Cart.create
    doll_one = products(:kitty)
    doll_two  = products(:angel)
    cart.add_product(doll_one.id).save!
    cart.add_product(doll_two.id).save!
    assert_equal 2, cart.line_items.size
    assert_equal doll_one.price + doll_two.price, cart.total_price
  end
  
  test "add duplicate product" do
    # добавление дубликата продукта в корзину
    cart = Cart.create
    doll = products(:kitty)
    cart.add_product(doll.id).save!
    cart.add_product(doll.id).save!
    assert_equal 1, cart.line_items.size
    assert_equal 2 * doll.price, cart.total_price
    assert_equal 2, cart.line_items[0].quantity
  end 
end