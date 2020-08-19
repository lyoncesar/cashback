require 'rails_helper'

RSpec.describe OfferContract do
  let(:params) do
    {
      advertiser_name: 'Acme',
      url: 'https://google.com/offers',
      description: '10% off',
      starts_at: '2020-08-20 00:00:00 UTC',
      ends_at: '',
      premium: 'false',
      state: nil
    }
  end

  context 'quando recebe todos os campos válidos' do
    it 'deve retornar sem erros' do
      validator = described_class.new

      expect(validator.call(params).errors.any?).to be_falsey
    end
  end

  context 'quando recebe campos inválidos' do
    context 'nome do anuciante' do
      context 'quando está vazio' do
        it 'retorna uma mensagem de erro' do
          params[:advertiser_name] = nil
          validator = described_class.new

          expect(
            validator.call(params).errors[:advertiser_name]
          ).to eq(['must be a string'])
        end
      end

      context 'quando possui menos de 3 caracteres' do
        it 'retorna uma mensagem de erro' do
          params[:advertiser_name] = 'Ed'
          validator = described_class.new

          expect(
            validator.call(params).errors[:advertiser_name]
          ).to eq(["Advertiser name is too short (minimum is 3 characters)"])
        end
      end

      context 'quando está duplicado' do
        let(:offer) { create(:offer) }

        it 'retorna uma mensagem de erro' do
          params[:advertiser_name] = offer.advertiser_name
          validator = described_class.new

          expect(
            validator.call(params).errors[:advertiser_name]
          ).to eq(["Advertiser name has already been taken"])
        end
      end
    end

    context 'url' do
      context 'quando está vazia' do
        it 'retorna uma mensagem de erro' do
          params[:url] = nil
          validator = described_class.new

          expect(
            validator.call(params).errors[:url]
          ).to eq(["must be a string"])
        end
      end

      context 'quando nẽo é uma url válida' do
        it 'retorna uma mensagem de erro' do
          params[:url] = 'acme'
          validator = described_class.new

          expect(
            validator.call(params).errors[:url]
          ).to eq(["is in invalid format"])
        end
      end
    end

    context 'descrição' do
      context 'quando está vazia' do
        it 'retorna uma mensagem de erro' do
          params[:description] = nil
          validator = described_class.new

          expect(
            validator.call(params).errors[:description]
          ).to eq(["must be a string"])
        end
      end

      context 'quando possui mais de 500 caracteres' do
        it 'retorna uma mensagem de erro' do
          description = 'Lorem ipsum ad tempor dictum nunc acsdf,
              hendrerit in urna magna pellentesque primis,
              nam sed quisque imperdiet hendrerit.
              inceptos leo dapibus praesent orci turpis accumsan ad tempor consectetur erat misdr,
              tincidunt ultricies magna aliquam nisi inceptos diam nibh inceptos nisl accumsan,
              eget eu dui donec massa sociosqu vehicula class scelerisque dui daf.
              viverra nibh sagittis sit porta ornare justo vestibulum dictumsttsadfe,'

          params[:description] = description
          validator = described_class.new

          expect(
            validator.call(params).errors[:description]
          ).to eq(["Description is too long (maximum is 500 characters)"])
        end
      end
    end

    context 'premium' do
      context 'quando não é booleano' do
        it 'retorna uma mensagem de erro' do
          params[:premium] = 'Teste'
          validator = described_class.new

          expect(
            validator.call(params).errors[:premium]
            ).to eq(["must be boolean"])
        end
      end
    end
  end
end
