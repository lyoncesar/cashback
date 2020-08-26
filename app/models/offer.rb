class Offer < ApplicationRecord
  include AASM

  attr_accessor :current_user_admin

  enum state: {disabled: 0, enabled: 1}

  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness:true, length: {minimum: 3}
  validates :description, length: {maximum: 500 }
  validates :url, format: URI::regexp(%w[http https])

  aasm column: :state, enum: true do
    state :disabled, initial: true
    state :enabled

    event :enable do
      transitions from: :disabled, to: :enabled, guard: :can_enable?
    end

    event :disable do
      transitions from: :enabled, to: :disabled, guard: :can_disable?
    end
  end

  scope :may_enable, -> do
    offers = []
    disabled.find_each do |offer|
      offers << offer if offer.may_enable?
    end

    offers
  end

  scope :may_disable, -> do
    offers = []
    enabled.find_each do |offer|
      offers << offer if offer.may_disable?
    end

    offers
  end

  scope :order_enabled_premium, -> do
    enabled.order(premium: :desc, id: :asc)
  end

  scope :order_state, -> do
    order(state: :desc, id: :asc)
  end

  private

  def can_enable?
    state_policy.can_enable?
  end

  def can_disable?
    state_policy.can_disable?
  end

  def state_policy
    OfferStatePolicy.new(starts_at, ends_at, current_user_admin)
  end
end

