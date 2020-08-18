class OffersController < ApplicationController
  before_action :current_offer, only: %w[edit update]

  def index
    @offers = Offer.all
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      flash['success'] = "The offer #{@offer.advertiser_name} has been created with success."
      redirect_to offers_path
    else
      flash['error'] = @offer.errors.full_messages
      render :new
    end
  end

  def update
    if @offer.update(offer_params)
      flash[:success] = "The offer #{@offer.advertiser_name} has been updated."
      redirect_to offers_path
    else
      flash[:error] = @offer.errors.full_messages
      render :edit
    end
  end

  private

  def current_offer
    @offer = Offer.find(params[:id])
  end

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
