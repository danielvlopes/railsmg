namespace :github do
  desc "Fetch all user projects from github"

  task :fetch => :environment do
    User.all(:conditions => 'github IS NOT NULL').each do |user|
      puts "Fetching projects for #{user}"
      user.fetch_projects!
    end
  end
end