namespace :user do
  desc "Generate permalinks for all user without it"

  task :generate_permalinks => :environment do
    User.all(:conditions => { :permalink => nil }).each do |u|
      u.generate_permalink
      u.save
    end
  end
end