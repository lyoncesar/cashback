module HomeHelper
  def admin_offers
    if current_user.admin?
      content_tag(:div) do
        link_to t('home.offers_admin'), offers_path, :class => 'btn btn-link float-right'
      end
    end
  end

  def offer_premium(offer_premium)
    if offer_premium
      content_tag(:div, class: 'text-right') do
        content_tag(:span, t('home.premium'), class: 'badge badge-danger badge-premium border border-light rounded-pill position-absolute  shadow')
      end
    end
  end
end
