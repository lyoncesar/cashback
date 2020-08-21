require 'rails_helper'

RSpec.describe UpdateOfferState do
  let(:offer) { create(:offer) }

  context 'quando altera o status de uma oferta' do
    context 'quando a oferta existe' do
      it 'deve retornar verdadeiro' do
        offer_id = offer.id
        new_state = 'enabled'
        service = described_class.new(offer_id, new_state)

        expect(service.call).to be_truthy
      end
    end
  end
end
