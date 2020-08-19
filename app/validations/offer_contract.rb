class OfferContract < Dry::Validation::Contract
  params do
    required(:advertiser_name).value(:string)
    required(:url).value(:string, format?: URI.regexp(%w(http https)))
    optional(:premium).maybe(:bool)
    required(:starts_at).value(:date)
    optional(:ends_at).maybe(:date)
    required(:description).value(:string)
    optional(:state).maybe(:string)
  end

  rule(:advertiser_name) do
    key.failure(
      'Advertiser name is too short (minimum is 3 characters)'
    ) if value.length < 3

    key.failure(
      'Advertiser name has already been taken'
    ) if duplicate_advertiser_name?(value)
  end

  rule(:description) do
    key.failure(
      'Description is too long (maximum is 500 characters)'
    ) if value.length > 500
  end

  def duplicate_advertiser_name?(name)
    return true if Offer.find_by(advertiser_name: name)

    false
  end
end
