set :output, {:error => File.join(File.dirname(__FILE__), ".." , "log" , "cron_error.log")}

every 1.day, :at => '4:00 am' do
  rake "github:fetch RAILS_ENV=production"
end