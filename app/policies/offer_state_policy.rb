class OfferStatePolicy
  def initialize(starts_at, ends_at)
    @starts_at = starts_at.strftime("%Y %m %d") unless starts_at.blank?
    @ends_at = ends_at.strftime("%Y %m %d") unless ends_at.blank?
    @admin_user = admin_user
  end

  def can_enable?
    return true if today_greater_or_equal_start && ends_blank?
    return true if today_greater_or_equal_start && today_less_or_equal_end
    return false if today_greater_or_equal_start && today_greater_or_equal_end

    false
  end

  def can_disable?
    return true if starts_blank? || today_less_start
    return false if ends_blank? && today_greater_or_equal_start
    return false if ends_blank?
    return true if today_greater_end
    return false if today_equal_end && today_greater_or_equal_start

    false
  end

  private

  attr_reader :starts_at, :ends_at, :admin_user

  def today_greater_or_equal_start
    today >= starts_at
  end

  def today_greater_or_equal_end
    today >= ends_at
  end

  def today_less_start
    today < starts_at
  end

  def today_less_or_equal_end
    today <= ends_at
  end

  def today_equal_end
    today == ends_at
  end

  def starts_blank?
    starts_at.blank?
  end

  def ends_blank?
    ends_at.blank?
  end

  def today_greater_end
    today > ends_at
  end

  def today
    Date.today.strftime("%Y %m %d")
  end
end
