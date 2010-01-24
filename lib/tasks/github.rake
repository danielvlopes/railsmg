namespace :github do
  desc "Fetch all user projects from github"

  task :fetch => :environment do
    User.all(:conditions => "github IS NOT NULL").in_groups_of(100, false) do |group|
      group.each do |user|
        puts "Fetching projects for #{user}"
        user.fetch_projects!
      end

      sleep 65
    end
  end
end
