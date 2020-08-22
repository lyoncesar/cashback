require 'rails_helper'

RSpec.describe OfferStatePolicy do
  let(:offer) { create(:offer) }

  context '.can_enable?' do
    context 'quando hoje é o início da oferta' do
      context 'e o encerramento é futuro' do
        it 'retorna verdadeiro' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = 3.days.from_now
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_truthy
        end
      end

      context 'e o encerramento é hoje' do
        it 'retorna verdadeiro' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = 0.day.from_now
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_truthy
        end
      end

      context 'e o encerramento era ontem' do
        it 'retorna false' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = 1.day.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end

      context 'e o encerramento está vazio' do
        it 'retorna verdadeiro' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = nil
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_truthy
        end
      end
    end

    context 'quando a oferta ainda não iniciou' do
      context 'e o encerramento da oferta é futuro' do
        it 'retorna falso' do
          offer.starts_at = 3.days.from_now
          offer.ends_at = 5.days.from_now
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end

      context 'e o encerramento da oferta já passou' do
        it 'retorna falso' do
          offer.starts_at = 3.days.from_now
          offer.ends_at = 1.day.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end

      context 'e o encerramento da oferta está vazio' do
        it 'retorna falso' do
          offer.starts_at = 3.days.from_now
          offer.ends_at = nil
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end
    end

    context 'quando já passou a data de encerramento da oferta' do
      context 'e a data de inicio é o dia anterior' do
        it 'retorna falso' do
          offer.starts_at = 1.day.ago
          offer.ends_at = 1.day.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end

      context 'e a data de inicio é hoje' do
        it 'retorna falso' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = 1.day.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end

      context 'e a data de inicio é futura' do
        it 'retorna falso' do
          offer.starts_at = 1.day.from_now
          offer.ends_at = 1.day.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_enable?).to be_falsey
        end
      end
    end
  end

  context '.can_disable?' do
    let(:offer) { create(:offer_enabled) }

    context 'quando o encerramento da oferta é hoje' do
      context 'e a data de início foi o dia anterior' do
        it 'retorna falso' do
          offer.starts_at = 1.day.ago
          offer.ends_at = 0.day.from_now
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_disable?).to be_falsey
        end
      end

      context 'e a data de início é hoje' do
        it 'retorna falso' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = 0.day.from_now
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_disable?).to be_falsey
        end
      end
    end

    context 'quando o encerramento da oferta já passou' do
      context 'e a data de início já passou' do
        it 'retorna verdadeiro' do
          offer.starts_at = 4.days.ago
          offer.ends_at = 3.days.ago
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_disable?).to be_truthy
        end
      end
    end

    context 'quando o encerramento da oferta não é preenchido' do
      context 'e o início da oferta é hoje' do
        it 'retorna falso' do
          offer.starts_at = 0.day.from_now
          offer.ends_at = nil
          policy = described_class.new(offer.starts_at, offer.ends_at)

          expect(policy.can_disable?).to be_falsey
        end
      end
    end
  end
end
