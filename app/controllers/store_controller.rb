class StoreController < ApplicationController
  def index
    @products = Product.order(:price)
    # счетчик посещения действия index контроллера store
    if session[:counter].nil?
      session[:counter] = 1
    else
      session[:counter] += 1
    end
    @counter = session[:counter]
  end
end
