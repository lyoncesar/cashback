require 'rails_helper'

RSpec.describe CreateOffer do
  context '.process' do
    it 'Cria uma nova oferta' do
      params = {
        advertiser_name: 'Google',
        url: 'https://google.com.br',
        premium: false,
        starts_at: Time.zone.now,
        ends_at: nil,
        description: 'Teste'
      }

      service = described_class.new(params)

      expect{service.call}.to change{Offer.count}.by(1)
    end
  end
end
