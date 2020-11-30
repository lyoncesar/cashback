class OfferSerializer
  include FastJsonapi::ObjectSerializer
  attributes :advertiser_name,
             :url,
             :premium,
             :starts_at,
             :ends_at,
             :description,
             :created_at,
             :updated_at,
             :state
end
