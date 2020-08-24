require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'deve salvar uma oferta sem erros' do
    expected_attributes = {
      advertiser_name: 'Google',
      url: 'https://google.com.br',
      premium: false,
      starts_at: Time.zone.now,
      ends_at: nil,
      description: 'Teste'
    }

    offer = described_class.new(expected_attributes)
    offer.save

    expect(offer).to be_persisted
    expect(offer.advertiser_name).to eq('Google')
  end

  context 'quando existem erros de validação' do
    context 'em campos vazios' do
      it 'retorna os erros de cada campo' do
        expected_attributes = {
          advertiser_name: '',
          url: '',
          premium: false,
          starts_at: nil,
          ends_at: nil,
          description: ''
        }

        offer = described_class.new(expected_attributes)
        offer.save
        expect(offer.errors.full_messages).to eq([
          "Advertiser name can't be blank",
          "Advertiser name is too short (minimum is 3 characters)",
          "Url can't be blank",
          "Url is invalid",
          "Description can't be blank",
          "Starts at can't be blank"
        ])
      end
    end

    context 'de unicidade no nome do anunciante' do
      before do
        Offer.create({
          advertiser_name: 'Google',
          url: 'https://google.com.br',
          premium: false,
          starts_at: Time.zone.now,
          ends_at: nil,
          description: 'Teste'
        })
      end

      it 'retorna um erro campo duplicado' do
        expected_attributes = {
          advertiser_name: 'Google',
          url: 'https://google.com.br',
          premium: false,
          starts_at: Time.zone.now,
          ends_at: nil,
          description: 'Teste'
        }

        offer = described_class.new(expected_attributes)
        offer.save

        expect(offer.errors.full_messages).to eq(["Advertiser name has already been taken"])
      end
    end

    context 'no limite de caracteres do campo descrição' do
      it 'retorna um erro de campo longo' do
        expected_attributes = {
          advertiser_name: 'Google',
          url: 'https://google.com',
          premium: false,
          starts_at: Time.zone.now,
          ends_at: nil,
          description: "Lorem ipsum ad tempor dictum nunc acsdf,
            hendrerit in urna magna pellentesque primis,
            nam sed quisque imperdiet hendrerit.
            inceptos leo dapibus praesent orci turpis accumsan ad tempor consectetur erat misdr,
            tincidunt ultricies magna aliquam nisi inceptos diam nibh inceptos nisl accumsan,
            eget eu dui donec massa sociosqu vehicula class scelerisque dui daf.
            viverra nibh sagittis sit porta ornare justo vestibulum dictumsttsadfe,"
        }

        offer = described_class.new(expected_attributes)
        offer.save

        expect(offer.errors.full_messages).to eq(["Description is too long (maximum is 500 characters)"])
      end
    end

    context 'na url do anunciante' do
      it 'retorna um erro na url' do
        expected_attributes = {
          advertiser_name: 'Google',
          url: 'google',
          premium: false,
          starts_at: Time.zone.now,
          ends_at: nil,
          description: 'Teste'
        }

        offer = described_class.new(expected_attributes)
        offer.save

        expect(offer.errors.full_messages).to eq(["Url is invalid"])
      end
    end
  end

  context 'quando usa máquina de estado' do
    context 'altera o estado de uma oferta' do
      let(:offer) { create(:offer) }

      context 'para habilitado' do
        context 'quando a oferta inicia no dia de hoje' do
          it 'efetua a atualização' do
            offer.starts_at = Date.today

            expect(offer.enable).to be_truthy
            expect(offer).to be_persisted
          end
        end

        context 'quando a oferta foi agendada para o dia anterior' do
          it 'efetua a atualização' do
            offer.starts_at = 1.day.ago

            expect(offer.enable).to be_truthy
            expect(offer).to be_persisted
          end
        end

        context 'quando a oferta foi agendada para o dia seguinte' do
          it 'rejeita a atualização' do
            offer.starts_at = 1.day.from_now

            expect(offer.may_enable?).to be_falsey
          end
        end

        context 'quando a oferta já está ativa' do
          let(:offer) { create(:offer, state: :enabled) }

          it 'rejeita a atualização' do
            expect(offer.may_enable?).to be_falsey
          end
        end
      end

      context 'para desabilitado' do
        let(:offer) { create(:offer, state: :enabled) }

        context 'quando a oferta encerra no dia de hoje' do
          it 'rejeita a atualização' do
            offer.ends_at = Date.today

            expect(offer.may_disable?).to be_truthy
          end
        end

        context 'quando o encerramento da oferta foi agendado para o dia anterior' do
          it 'efetua a atualização' do
            offer.ends_at = 1.day.ago

            expect(offer.disable).to be_truthy
            expect(offer).to be_persisted
          end
        end

        context 'quando o encerramento da oferta foi agendado para o dia seguinte' do
          it 'rejeita a atualização' do
            offer.ends_at = 1.day.from_now

            expect(offer.may_enable?).to be_falsey
          end
        end

        context 'quando a oferta não não possui data de encerramento' do
          it 'rejeita a atualização' do
            offer.ends_at = ''

            expect(offer.may_enable?).to be_falsey
          end
        end

        context 'quando a oferta já está encerrada' do
          let(:offer) { create(:offer) }

          it 'rejeita a atualização' do
            offer.ends_at = 1.day.ago

            expect(offer.may_enable?).to be_falsey
          end
        end
      end
    end
  end
end
