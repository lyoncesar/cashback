class Offer < ApplicationRecord
  enum state: {disabled: 0, enabled: 1}

  validates :advertiser_name, :url, :description, :starts_at, presence: true
  validates :advertiser_name, uniqueness:true, length: {minimum: 3}
  validates :description, length: {maximum: 500 }
  validates :url, format: URI::regexp(%w[http https])
end
