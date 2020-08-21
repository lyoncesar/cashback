require 'rails_helper'

RSpec.describe "Offers", type: :feature do
  context 'qunado o usuário está logado' do
    context 'como admin' do
      before do
        user = create(:admin_user)
        sign_in user
      end

      context 'quando entra na tela de ofertas' do
        before do
          3.times { create(:offer) }
        end
        it 'exibe todas as ofertas disponíveis' do
          visit offers_path

          expect(page).to have_content('Offers')
          expect(page).to have_xpath(
            "/html/body/div[@id='main']/div[@class='container']/div[@class='content']/div/div[@class='span12']/div[@class='table-responsive']/table[@class='table table-bordered']/tbody/tr",
            :count => 3
          )
        end
      end

      context 'quando cria uma nova oferta' do
        it 'exibe o formulário para criação de oferta' do
          visit new_offer_path

          expect(page).to have_content('New Offer')
          expect(page).to have_xpath(
            "/html/body/div[@id='main']/div[@class='container']/div[@class='content']/div/div[@class='span12']/div[2]/form[@id='new_offer']"
          )
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

      context 'quando edita uma oferta' do
        let(:offer) { create(:offer) }

        it 'exibe o formulário de edição' do
          visit edit_offer_path(offer)

          expect(page).to have_content("Edit offer #{offer.advertiser_name}")
        end

        it 'retorna para a lista de ofertas' do
          visit edit_offer_path(offer)
          fill_in 'Description', with: '15% off'

          click_button 'Submit'

          expect(page.current_path).to eq(offers_path)
        end

        it 'exibe mensagem de erro quando existe' do
          visit edit_offer_path(offer)
          fill_in 'Advertiser name', with: nil

          click_button 'Submit'

          expect(page).to have_content("Advertiser name is too short (minimum is 3 characters)")
        end
      end

      context 'quando remove uma oferta' do
        before do
          create(:offer)
        end

        it 'exibe uma mensagem de confirmação na listagem de ofertas' do
          visit offers_path
          find(
            :xpath,
            "/html/body/div[@id='main']/div[@class='container']/div[@class='content']/div/div[@class='span12']/div[@class='table-responsive']/table[@class='table table-bordered']/tbody/tr[1]/td[4]/a[3]"
          ).click

          expect(page).to have_content('The offer been deleted')
        end
      end

      context 'quando desabilita uma oferta' do
        before do
          create(:offer, advertiser_name: 'Facebook', state: 'enabled')
        end

        it 'retorna uma mensagem de confirmação' do
          visit offers_path
          find(
            :xpath,
            "/html/body/div[@id='main']/div[@class='container']/div[@class='content']/div/div[@class='span12']/div[@class='table-responsive']/table[@class='table table-bordered']/tbody/tr[1]/td[4]/a[3]"
          ).click

          expect(page).to have_content('The offer been deleted')
        end
      end

      context 'quando habilita uma oferta' do
        before do
          create(:offer, advertiser_name: 'Facebook', state: 'disabled')
        end

        it 'retorna uma mensagem de confirmação' do
          visit offers_path
          find(
            :xpath,
            "/html/body/div[@id='main']/div[@class='container']/div[@class='content']/div/div[@class='span12']/div[@class='table-responsive']/table[@class='table table-bordered']/tbody/tr[1]/td[4]/a[2]"
          ).click

          expect(page).to have_content('The offer Facebook been updated')
        end
      end
    end

    context 'como usuário padrão' do
      before do
        user = create(:user)
        sign_in user
      end

      context 'ao acessar a lista de ofertas' do
        context 'redireciona para o root_path' do
          it 'exibe uma mensagem de acesso bloqueado' do
            visit offers_path

            expect(page.current_path).to eq(root_path)
            expect(page).to have_content('This page only accessible by admin users.')
          end
        end
      end

      context 'ao acessar o formulário para criação de ofertas' do
        context 'redireciona para o root_path' do
          it 'exibe uma mensagem de acesso bloqueado' do
            visit new_offer_path

            expect(page.current_path).to eq(root_path)
            expect(page).to have_content('This page only accessible by admin users.')
          end
        end
      end
    end
  end

  context 'quando o usuário não está logado' do
    context 'ao acessar a lista de ofertas' do
      context 'redireciona para a tela de login' do
        it 'exibe uma mensagem pedindo o login do usuário' do
          visit offers_path

          expect(page.current_path).to eq(user_session_path)
          expect(page).to have_content('You need to sign in or sign up before continuing.')
        end
      end
    end

    context 'ao acessar o formulário para criação de ofertas' do
      context 'redireciona para a tela de login' do
        it 'exibe uma mensagem pedindo o login do usuário' do
          visit offers_path

          expect(page.current_path).to eq(user_session_path)
          expect(page).to have_content('You need to sign in or sign up before continuing.')
        end
      end
    end
  end
 end
