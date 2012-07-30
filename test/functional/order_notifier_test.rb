require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "recieved" do
    mail = OrderNotifier.recieved(orders(:one))
    assert_equal "Order confirmation in Tilda Shop", mail.subject
    assert_equal ["andrew.babichev@gmail.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /1 x Soft Kitty/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Order sent from Tilda Shop", mail.subject
    assert_equal ["andrew.babichev@gmail.com"], mail.to
    assert_equal ["depot@example.com"], mail.from
    assert_match /<td>1 &times;<\/td>\s*<td>Soft Kitty<\/td>/, mail.body.encoded
  end

end
