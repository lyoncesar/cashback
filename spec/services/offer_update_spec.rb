require 'rails_helper'

RSpec.describe OfferUpdate do
  context 'quando atualiza uma oferta' do
    context 'e as validações do model são aprovadas' do
      let(:offer) { create(:offer) }
      let(:params) do
        {
          advertiser_name: 'Acme',
          url: 'https://acme.com/offers',
          description: '10% off',
          starts_at: 1.day.ago,
          ends_at: 2.days.from_now,
          premium: true
        }
      end

      it 'aplica a atualização' do
        service = described_class.new(offer.id, params)

        expect(service.call).to be_truthy
      end
    end

    context 'e as validações do model são rejeitadas' do
      let(:offer) { create(:offer) }
      let(:params) do
        {
          advertiser_name: 'A',
          url: 'acme.'
        }
      end

      it 'aplica a atualização' do
        service = described_class.new(offer.id, params)
        service.call

        expect(service.current_offer.errors.full_messages).to eq(
          [
            "Description can't be blank",
            "Starts at can't be blank",
            "Advertiser name is too short (minimum is 3 characters)",
            "Url is invalid"
          ]
        )
      end
    end
  end

  let(:offer) { create(:offer, state: 'disabled') }

  context 'quando atualiza apenas o estado de uma oferta' do
    context 'enviado por um usuário admin' do
      it 'atualiza a oferta' do
        params = { state: 'enabled'}
        admin_user = true

        service = described_class.new(offer.id, params, admin_user)
        service.call

        offer.reload

        expect(offer.state).to eq('enabled')
      end

      it 'atualiza uma oferta que não seria aprovada para um usuário normal' do
        offer = create(:offer_cant_disable, state: 'enabled')
        params = { state: 'disabled'}
        admin_user = true

        service = described_class.new(offer.id, params, admin_user)
        service.call

        offer.reload

        expect(offer.state).to eq('disabled')
      end
    end

    context 'enviado por um usuário padrão' do
      context 'executa a validação padrão' do
        context 'atualiza a oferta' do
          it 'quando ela pode ser atualizada' do
            params = { state: 'enabled'}
            admin_user = false

            service = described_class.new(offer.id, params, admin_user)
            service.call

            offer.reload

            expect(offer.state).to eq('enabled')
          end
        end

        context 'não atualiza a oferta' do
          let(:offer) { create(:offer_cant_disable, state: 'enabled') }

          it 'quando a validação retorna negada' do
            params = { state: 'disabled' }
            admin_user = false

            service = described_class.new(offer.id, params, admin_user)
            service.call

            offer.reload

            expect(offer.state).to eq('enabled')
          end
        end
      end
    end
  end
end
