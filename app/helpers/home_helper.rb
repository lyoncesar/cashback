module HomeHelper
  def user_signed_in_email
    if user_signed_in?
      content_tag(:span, "#{current_user.email}", :class => 'navbar-text text-light nav-righ')
    end
  end
  def user_signed_in_edit
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to 'Editar perfil', edit_user_registration_path, :class => 'nav-link text-light nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to "Registrar-se", new_user_registration_path, :class => 'nav-link text-light nav-righ'
      end
    end
  end

  def user_signed_in_logout
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to "Logout", destroy_user_session_path, method: :delete, :class => 'nav-link text-light nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to "Login", new_user_session_path, :class => 'nav-link text-light nav-righ'
      end
    end
  end

  def admin_offers
    if current_user.admin?
      content_tag(:div) do
        link_to "Offers admin", offers_path, :class => 'btn btn-link float-right'
      end
    end
  end
end
