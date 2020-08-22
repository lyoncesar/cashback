require 'rails_helper'

Rails.application.load_tasks
RSpec.describe 'offer_update_state:process', type: :task do
  subject { Rake::Task["offer_update_state:process"] }

  context 'quando muitas ofertas podem ser atualizadas' do
    context 'e muitas ofertas não podem ser atualizadas' do
      let(:offers_may_enable) do
        5.times {create(:offer)}
      end

      let(:offers_dont_enable) do
        5.times do
          create(:offer, starts_at: 1.day.ago, ends_at: 1.day.ago)
        end
      end

      let(:offers_may_disable) do
        5.times do
          create(:offer_may_disable)
        end
      end

      let(:offers_dont_disable) do
        5.times do
          create(:offer_dont_disable)
        end
      end

      before do
        offers_may_enable
        offers_dont_enable
        offers_may_disable
        offers_dont_disable

        Rake::Task["offer_update_state:enable"].reenable
        Rake::Task["offer_update_state:disable"].reenable
      end
      context 'atualiza as offertas permitidas' do
        it 'e mantem o mesmo estado nas que não podem ser atualizadas' do
          expect(Offer.may_enable.count).to eq(5)
          expect(Offer.may_disable.count).to eq(5)

          subject.invoke

          expect(Offer.may_enable.count).to eq(0)
          expect(Offer.may_disable.count).to eq(0)
          expect(Offer.enabled.count).to eq(10)
          expect(Offer.disabled.count).to eq(10)
        end
      end
    end
  end
end

RSpec.describe 'offer_update_state:enable', type: :task do
  subject { Rake::Task["offer_update_state:enable"] }

  context 'quando muitas ofertas podem ser atualizadas' do
    before do
      5.times { create(:offer) }

      Rake::Task["offer_update_state:enable"].reenable
    end
    context 'atualiza as offertas permitidas' do
      it 'e mantem o mesmo estado nas que não podem ser atualizadas' do
        expect(Offer.may_enable.count).to eq(5)
        subject.invoke
        expect(Offer.may_enable.count).to eq(0)
      end
    end
  end
end

RSpec.describe 'offer_update_state:disable', type: :task do
  subject { Rake::Task["offer_update_state:disable"] }

  context 'quando muitas ofertas podem ser atualizadas' do
    before do
      5.times { create(:offer_enabled, starts_at: 1.day.ago, ends_at: 1.day.ago) }

      Rake::Task["offer_update_state:disable"].reenable
    end
    context 'atualiza as offertas permitidas' do
      it 'e mantem o mesmo estado nas que não podem ser atualizadas' do
        expect(Offer.may_disable.count).to eq(5)
        subject.invoke
        expect(Offer.may_disable.count).to eq(0)
      end
    end
  end
end
