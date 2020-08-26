module OffersHelper
  def offer_new_state(state)
    return 'Disabled' if state == 'enabled'

    'Enabled'
  end

  def offer_new_state_option(state)
    return 'Disable' if state == 'enabled'

    'Enable'
  end
end
