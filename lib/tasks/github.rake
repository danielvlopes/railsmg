namespace :github do
  desc "Fetch all user projects from github"

  task :fetch => :environment do
    User.active.find_in_batches(:batch_size => 100) do |group|
      group.each do |user|
        puts "Fetching projects for #{user}"
        user.fetch_github_projects!
      end

      sleep 65
    end
  end
end
