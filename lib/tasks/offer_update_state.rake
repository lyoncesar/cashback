namespace :offer_update_state do
  desc "Update Offers state"
  task process: :environment do
    Rake::Task["offer_update_state:enable"].invoke
    Rake::Task["offer_update_state:disable"].invoke
  end

  desc "Update Offer state to enabled"
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

  desc "Update Offer state to enabled"
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

  private

  def update_state_log
    Logger.new("#{Rails.root}/log/offer_update_state_#{Rails.env}.log")
  end
end
