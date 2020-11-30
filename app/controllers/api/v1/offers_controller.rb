module Api
  module V1
    class OffersController < Api::BaseController
      def index
        @offers = Offer.order('created_at DESC')
        render json: OfferSerializer.new(Offer.all).serialized_json, status: :ok
      end
    end
  end
end
