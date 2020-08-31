module OffersHelper
  def offer_new_state(state)
    return t('offers.disabled') if state == 'enabled'

    t('offers.enabled')
  end

  def offer_new_state_option(state)
    return t('offers.disable') if state == 'enabled'

    t('offers.enable')
  end
end
