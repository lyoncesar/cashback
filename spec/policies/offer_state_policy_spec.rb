require 'rails_helper'

RSpec.describe OfferStatePolicy do
  let(:offer) { create(:offer) }

  context '.can_enable?' do
    context 'quando hoje é o início da oferta' do
      it 'retorna verdadeiro' do
        offer.starts_at = Date.today
        policy = described_class.new(offer.starts_at, offer.ends_at)

        expect(policy.can_enable?).to be_truthy
      end
    end

    context 'quando a oferta ainda não iniciou' do
      it 'retorna falso' do
        offer.starts_at = 3.days.from_now
        policy = described_class.new(offer.starts_at, offer.ends_at)

        expect(policy.can_enable?).to be_falsey
      end
    end
  end

  context '.can_disable?' do
    context 'quando o encerramento da oferta é hoje' do
      it 'retorna falso' do
        offer.ends_at = Date.today
        policy = described_class.new(offer.starts_at, offer.ends_at)

        expect(policy.can_disable?).to be_falsey
      end
    end

    context 'quando o encerramento da oferta já passou' do
      it 'retorna verdadeiro' do
        offer.ends_at = 3.days.ago
        policy = described_class.new(offer.starts_at, offer.ends_at)

        expect(policy.can_disable?).to be_truthy
      end
    end

    context 'quando o encerramento da oferta não é preenchido' do
      it 'retorna falso' do
        offer.ends_at = nil
        policy = described_class.new(offer.starts_at, offer.ends_at)

        expect(policy.can_disable?).to be_falsey
      end
    end
  end
end
