module NavigationHelper
  def user_signed_in_email
    if user_signed_in?
      content_tag(:span, "#{current_user.email}", :class => 'navbar-text text-light nav-righ')
    end
  end

  def user_signed_in_edit
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to t('users.edit'), edit_user_registration_path, :class => 'nav-link text-light nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to t('users.sign_up'), new_user_registration_path, :class => 'nav-link text-light nav-righ'
      end
    end
  end

  def user_signed_in_logout
    if user_signed_in?
      content_tag(:li, class: "nav-item") do
        link_to t('sessions.logout'), destroy_user_session_path, method: :delete, :class => 'nav-link text-light nav-righ'
      end
    else
      content_tag(:li, class: "nav-item") do
        link_to t('sessions.login'), new_user_session_path, :class => 'nav-link text-light nav-righ'
      end
    end
  end

  def user_signed_in_home
    if user_signed_in?
      content_tag(:div) do
        link_to(
          image_tag('logo.png',
                    :class => 'row align-self-center mb-2',
                    :width => '62',
                    :height => '62'
                   ),
          root_path, :class => 'navbar-brand text-light')
      end
    end
  end
end

