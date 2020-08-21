class UpdateOfferState
  def initialize(offer_id, new_state)
    @offer_id = offer_id
    @new_state = new_state
  end

  def call
    update
  end

  def offer
    begin
      Offer.find(offer_id)
    rescue ActiveRecord::RecordNotFound
      false
    end
  end

  private

  attr_reader :offer_id, :new_state

  def update
    offer.update(build_offer_update)
  end

  def build_offer_update
    {
      state: new_state
    }
  end
end
