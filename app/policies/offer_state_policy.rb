class OfferStatePolicy
  def initialize(starts_at, ends_at)
    @starts_at = starts_at
    @ends_at = ends_at

  end

  def can_enable?
    return true if current_day >= starts_at

    false
  end

  def can_disable?
    if ends_at.blank?
      false
    elsif current_day > ends_at
      true
    else
      false
    end
  end

  private

  attr_reader :starts_at, :ends_at

  def current_day
    Date.today
  end
end
