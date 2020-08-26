class OffersController < ApplicationController
  before_action :current_offer, only: %w[edit destroy]
  before_action :authorize_admin

  def index
    @offers = Offer.order_state
  end

  def new
    @offer = Offer.new
  end

  def edit
  end

  def create
    @offer = Offer.new(offer_params)

    if @offer.save
      redirect_to offers_path, notice: "The offer #{@offer.advertiser_name} been created."
    else
      flash.now['error'] = @offer.errors.full_messages
      render :new
    end
  end

  def update
    update = OfferUpdate.new(params[:id], offer_params, admin_user?)

    if update.call
      redirect_to offers_path,
        notice: "The offer #{update.current_offer.advertiser_name} been updated."
    else
      @offer = update.current_offer
      flash.now['error'] = @offer.errors.full_messages
      render :edit
    end
  end

  def destroy
    @offer.destroy
    redirect_to offers_path, notice: "The offer been deleted."
  end

  private

  def authorize_admin
    return if current_user.admin?

    redirect_to root_path, notice: 'This page only accessible by admin users.'
  end

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
