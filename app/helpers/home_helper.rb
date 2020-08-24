module HomeHelper
  def user_signed_in_email
    if user_signed_in?
      content_tag(:span, "User: #{current_user.email}", :class => 'navbar-text nav-righ')
    end
  end
  def user_signed_in_edit
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to 'Editar perfil', edit_user_registration_path, :class => 'nav-link nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to "Registrar-se", new_user_registration_path, :class => 'nav-link nav-righ'
      end
    end
  end

  def user_signed_in_logout
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to "Logout", destroy_user_session_path, method: :delete, :class => 'nav-link nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to "Login", new_user_session_path, :class => 'nav-link nav-righ'
      end
    end
  end
end
