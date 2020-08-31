module DeviseHelper
  def minimum_password_length(min_pass_length)
    if min_pass_length
      t('users.password_min_length', min_length: min_pass_length)
    else
      t('users.password')
    end
  end
end
