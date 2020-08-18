require 'rails_helper'

RSpec.describe Offer, type: :model do
  context 'quando cria uma nova oferta' do
    it 'deve salvar sem erros' do
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
  end
end
