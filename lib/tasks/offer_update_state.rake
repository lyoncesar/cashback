namespace :offer_update_state do
  desc "Schedule task to change Offer state to enabled"
  task enable: :environment do
    Offer.may_enable.each do |offer|
      begin
        update_state_log.info("Updating state of offer: #{offer.id}")
        offer.enable!
      rescue StandardError => e
        update_state_log.error(e.message)
      end
    end
  end

  desc "Schedule task to change Offer state to enabled"
  task disable: :environment do
    Offer.may_disable.each do |offer|
      begin
        update_state_log.info("Updating state of offer: #{offer.id}")
        offer.disable!
      rescue StandardError => e
        update_state_log.error(e.message)
      end
    end
  end

  def update_state_log
    Logger.new("#{Rails.root}/log/update_state_#{Rails.env}.log")
  end
end
