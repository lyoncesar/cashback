module OffersHelper
  def offer_new_state(state)
    return 'disabled' if state == 'enabled'

    'enabled'
  end

  def offer_new_state_option(state)
    return 'disable' if state == 'enabled'

    'enable'
  end
end
