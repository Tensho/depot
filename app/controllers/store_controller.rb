class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    @products = Product.order(:title)
    @cart = current_cart
    # счетчик посещения действия index контроллера store
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @counter = session[:counter]
  end
end
