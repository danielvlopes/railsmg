every 1.day, :at => '4:00 am' do
  rake "rake github:fetch RAILS_ENV=production"
end