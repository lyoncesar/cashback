require 'rails_helper'

RSpec.describe "Offers", type: :feature do
  context 'quando entra na tela de ofertas' do
    before do
      3.times { create(:offer) }
    end
    it 'exibe todas as ofertas disponíveis' do
      visit offers_path

      expect(page).to have_content('Offers')
      expect(page).to have_xpath('/html/body/table/tbody/tr', :count => 3)
    end
  end

  context 'quando cria uma nova ofera' do
    it 'exibe o formulário para criação de oferta' do
      visit new_offer_path

      expect(page).to have_content('New Offer')
    end
  end
 end
