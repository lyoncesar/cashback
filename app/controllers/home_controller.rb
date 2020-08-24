class HomeController < ApplicationController
  def index
    @offers = Offer.enabled
  end
end
