module DeviseHelper
  def minimum_password_length(min_pass_length)
    if min_pass_length
      "Password (#{min_pass_length} minimum)"
    else
      'Password'
    end
  end
end
