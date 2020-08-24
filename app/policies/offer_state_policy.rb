class OfferStatePolicy
  def initialize(starts_at, ends_at, admin_user = false)
    @starts_at = starts_at.strftime("%Y %m %d") unless starts_at.blank?
    @ends_at = ends_at.strftime("%Y %m %d") unless ends_at.blank?
    @admin_user = admin_user
  end

  def can_enable?
    return true if admin_user

    if ends_at.blank?
      return true if today >= starts_at
    end
    return true if todays_greater_or_equal_start_and_ends_at_blank
    return true if todays_greater_or_equal_start_at_and_todays_less_ends_at

    false
  end

  def can_disable?
    return true if admin_user

    if ends_at.blank?
      return false if today >= starts_at
    end

    return true if starts_blank_or_todays_greater_or_equal_starts_at
    return true if todays_less_or_equals_ends_at

    false
  end

  private

  attr_reader :starts_at, :ends_at, :admin_user

  def todays_greater_or_equal_start_at_and_todays_less_ends_at
    today >= starts_at && today < ends_at
  end

  def todays_greater_or_equal_start_and_ends_at_blank
    return true if today >= starts_at && ends_at.blank?

    false
  end

  def starts_blank_or_todays_greater_or_equal_starts_at
    return true if starts_at.blank? || today >= starts_at

    false
  end

  def todays_less_or_equals_ends_at
    today >= ends_at
  end

  def today
    Date.today.strftime("%Y %m %d")
  end
end
