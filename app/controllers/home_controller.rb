class HomeController < ApplicationController
  def index
    @offers = Offer.order_enabled_premium
  end
end
