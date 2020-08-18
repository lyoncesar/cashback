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
      expect(page).to have_xpath('/html/body/form')
    end

    context 'quando o formulário é preenchido' do
      it 'registra a oferta' do
        visit new_offer_path
        fill_in 'Advertiser name', with: 'Walmart'
        fill_in 'URL', with: 'https://walmart.com/offers'
        fill_in 'Description', with: '10% off'
        fill_in 'Starts at', with: Time.zone.now

        click_button 'Submit'

        expect(page.current_path).to eq(offers_path)
      end

      it 'retorna erros na tela para campos vazios' do
        visit new_offer_path
        fill_in 'Advertiser name', with: nil
        fill_in 'URL', with: 'https://walmart.com/offers'
        fill_in 'Description', with: '10% off'
        fill_in 'Starts at', with: Time.zone.now

        click_button 'Submit'

        expect(page).to have_content(
          'Advertiser name is too short (minimum is 3 characters)'
        )
      end
    end
  end
 end
