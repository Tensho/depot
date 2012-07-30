require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  test "buying a product" do
    LineItem.delete_all
    Order.delete_all
    kitty = products(:kitty)
    # посещение страницы каталога магазина
    get "/"
    assert_response :success
    assert_template "index"
    # выбор товара
    xml_http_request :post, '/line_items', product_id: kitty.id
    assert_response :success
    # добавление его в корзину
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal kitty, cart.line_items[0].product
    # оформление заказа
    get "/orders/new"
    assert_response :success
    assert_template "new"
    # заполнение и оптравка (POST с перенаправлениями) данных
    post_via_redirect "/orders", order: {
      name: "Andrew Babichev",
      address: "At the end of Earth",
      email: "andrew@example.com",
      pay_type: "Check"
    }
    assert_response :success
    assert_template "index"
    # корзина должна быть пуста после оформления заказа
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size
    # проверка базы данных
    # должен находиться только оформленный заказ
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]
    # должны быть соответствующие переданные данные
    assert_equal "Andrew Babichev", order.name
    assert_equal "At the end of Earth", order.address
    assert_equal "andrew@example.com", order.email
    assert_equal "Check", order.pay_type
    # должна быть соответствующая товарная позиция
    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal kitty, line_item.product
    # почта отправлена верно
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["andrew@example.com"], mail.to
    assert_equal 'Tilda Shop Administration <depot@example.com>', mail[:from].value
    assert_equal 'Order confirmation in Tilda Shop', mail.subject
  end
end
