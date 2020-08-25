module HomeHelper
  def admin_offers
    if current_user.admin?
      content_tag(:div) do
        link_to "Offers admin", offers_path, :class => 'btn btn-link float-right'
      end
    end
  end
end
