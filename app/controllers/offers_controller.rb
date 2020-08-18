class OffersController < ApplicationController
  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      flash['success'] = "The offer #{@offer.advertiser_name} have been created with success."
      redirect_to offers_path
    else
      flash['error'] = @offer.errors.full_messages
      render new_offer_path
    end
  end

  private

  def offer_params
    params.require(:offer).permit(
      :advertiser_name,
      :url,
      :description,
      :starts_at,
      :ends_at,
      :premium
    )
  end
end
