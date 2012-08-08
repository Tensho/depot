class StoreController < ApplicationController
  skip_before_filter :authorize

  def index
    # счетчик посещения действия index контроллера store
    # if session[:counter].nil?
    #   session[:counter] = 1
    # else
    #   session[:counter] += 1
    # end
    # @counter = session[:counter]

    if params[:set_locale]
      redirect_to store_path(locale: params[:set_locale])
    else
      @products = Product.order(:title)
      @cart = current_cart
    end
  end
end
