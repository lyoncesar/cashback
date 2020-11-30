module Api
  module V1
    class OffersController < Api::BaseController
      def index
        @offers = Offer.order('created_at DESC')
        render json: {status: 'SUCCESS', message: 'Ofertas carregadas', data: @offers}, status: :ok
      end
    end
  end
end
