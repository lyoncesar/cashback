class CreateOffer
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def call
    create_offer
  end

  private

  def create_offer
    offer = build_offer
    if offer.save
      offer
    else
      offer.errors.full_messages
    end
  end

  def build_offer
    Offer.new(
      advertiser_name: params.dig(:advertiser_name),
      url: params.dig(:url),
      premium: params.dig(:params),
      starts_at: params.dig(:starts_at),
      ends_at: params.dig(:ends_at),
      description: params.dig(:description)
    )
  end
end
