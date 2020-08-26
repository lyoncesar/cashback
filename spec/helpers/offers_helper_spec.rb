require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the OffersHelper. For example:
#
# describe OffersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe OffersHelper, type: :helper do
  describe 'offer_new_state_option' do
    context 'quando o estado informado é enabled' do
      it 'retorna disable' do
        expect(helper.offer_new_state_option('enabled')).to eq('Disable')
      end
    end

    context 'quando o estado informado é disabled' do
      it 'retorna o enable' do
        expect(helper.offer_new_state_option('disabled')).to eq('Enable')
      end
    end
  end

  describe 'offer_new_state' do
    context 'quando o estado atual é enabled' do
      it 'retorna disabled' do
        expect(helper.offer_new_state('enabled')).to eq('Disabled')
      end
    end

    context 'quando o estado atual é disabled' do
      it 'retorna enabled' do
        expect(helper.offer_new_state('disabled')).to eq('Enabled')
      end
    end
  end
end
