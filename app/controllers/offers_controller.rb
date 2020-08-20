class OffersController < ApplicationController
  before_action :current_offer, only: %w[edit update destroy]

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
      flash['success'] = "The offer #{@offer.advertiser_name} been created with success."
      redirect_to offers_path
    else
      flash.now['error'] = @offer.errors.full_messages
      render :new
    end
  end

  def update
    if @offer.update(offer_params)
      flash[:success] = "The offer #{@offer.advertiser_name} been updated."
      redirect_to offers_path
    else
      flash.now[:error] = @offer.errors.full_messages
      render :edit
    end
  end

  def destroy
    @offer.destroy
    flash[:success] = "The offer been destroyed"
    redirect_to offers_path
  end

  private

  def current_offer
    @offer = Offer.find(params.dig(:id))
  end

  def offer_params
    params.require(:offer).permit(
      :advertiser_name,
      :url,
      :description,
      :state,
      :starts_at,
      :ends_at,
      :premium
    )
  end
end
