desc "Offers state update"
task offer_update_state_process: :environment do
  Rake::Task["offer_update_state:process"].invoke
end

desc "Clear log file of rake task offer_update_state:process"
task clear_log_offer_update_state: :environment do
  return unless Date.today.sunday?

  file_name = "offer_update_state_#{Rails.env}.log"
  file_path = "#{Rails.root}/log/"
  log_file = File.open("#{file_path}#{file_name}")

  puts 'Deleting log file.'

  begin
    File.truncate(log_file, 0)
    puts 'File deleted.'
  rescue StandardError => e
    puts "#{e.message}"
  end
end
