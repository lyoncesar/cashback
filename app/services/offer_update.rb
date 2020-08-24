class OfferUpdate
  def initialize(offer_id,params, admin_user = false)
    @offer_id = offer_id
    @params = params
    @admin_user = admin_user
  end

  def call
    update!
  end

  def current_offer
    @current_offer ||= Offer.find(offer_id)
  end

  private

  attr_accessor :offer_id, :params, :admin_user

  def update!
    begin
      return update_state if params.include?(:state)

      current_offer.update(build_offer)
    rescue
      false
    end
  end

  def update_state
    current_offer.current_user_admin = admin_user
    return current_offer.enable! if params.dig(:state) == 'enabled'

    current_offer.disable!
  end

  def build_offer
    {
      advertiser_name: params.dig(:advertiser_name),
      url: params.dig(:url),
      description: params.dig(:description),
      starts_at: params.dig(:starts_at),
      ends_at: params.dig(:ends_at),
      premium: params.dig(:premium)
    }
  end
end
