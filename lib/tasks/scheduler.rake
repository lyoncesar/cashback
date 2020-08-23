desc "Offers state update"
task offer_update_state_process: :environment do
  Rake::Task["offer_update_state:process"].invoke
end

desc "Destroy log file of rake task offer_update_state:process"
task destroy_log_offer_udpate_state: :environment do
  return unless Date.today.sunday?

  log_file = 'offer_update_state_production.log'

  puts 'Deleting log file.'

  begin
    File.delete("#{Rails.root}/log/#{file_log}")
    puts 'File deleted.'
  rescue StandardError => e
    puts "#{e.message}"
  end
end
