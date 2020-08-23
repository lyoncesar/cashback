desc "Update state of Offers"
task offer_update_state_process: :environment do
  Rake::Task["offer_update_state:process"].invoke
end
