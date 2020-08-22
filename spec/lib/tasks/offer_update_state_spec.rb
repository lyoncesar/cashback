require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'offer_update_state:enable', type: :task do
  subject { Rake::Task["offer_update_state:enable"] }

  context 'quando executa a task' do
    context 'e mais de uma oferta pode ser atualizada' do
      before do
        5.times { create(:offer) }
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
end

RSpec.describe 'offer_update_state:disable', type: :task do
  subject { Rake::Task["offer_update_state:disable"] }

  context 'quando executa a task' do
    context 'e muitas ofertas podem ser atualizadas' do
      before do
        5.times { create(:offer_enabled, starts_at: 1.day.ago, ends_at: 1.day.ago) }
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
end
