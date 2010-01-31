# APP SETTINGS
set :application, "railsmg"
set :domain_name , "railsmg.org"

# GIT SETTINGS
set :scm, :git
set :repository,  "git@github.com:danielvlopes/railsmg.git"
set :branch, "master"
set :deploy_via, :remote_cache

# SSH SETTINGS
set :user , "git"
set :deploy_to, "~/#{application}"
set :shared_directory, "#{deploy_to}/shared"
set :use_sudo, false
set :group_writable, false
default_run_options[:pty] = true

# ROLES
role :app, domain_name
role :web, domain_name
role :db,  domain_name, :primary => true

#TASKS
after 'deploy:symlink' do
  assets.jammit
  deploy.update_crontab
end

after 'deploy:update_code', 'db:upload_database_yaml'

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
  
  desc "Update the crontab file"
  task :update_crontab, :roles => :db do
    run "cd #{release_path} && whenever --update-crontab #{application}"
  end  
end

namespace :log do
  desc "tail production log files"
  task :tail, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts  # break one line
      puts "#{channel[:host]}: #{data}"
      break if stream == :err
    end
  end
end

namespace :assets do
  desc "run jammit locally and upload files to current release"
  task :jammit, :roles => :web do
    root_path = File.join(File.dirname(__FILE__), "..")
    run_locally "cd #{root_path} && jammit"
    upload "#{root_path}/public/assets", "#{current_release}/public", :via => :scp, :recursive => true
  end
end

namespace :db do

  desc "remote backup and download the MySQL database"
  task :backup, :roles => :db do
    backup_rb ||= "#{current_path}/lib/backup.rb"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} backup #{deploy_to} ; fi"
    get "#{deploy_to}/etc/dump.tar.gz", "#{Date.today.to_s}.tar.gz"
    run "rm #{deploy_to}/etc/dump.tar.gz"
  end

  desc "upload and restore of remote MySQL database"
  task :restore, :roles => :db do
    unless File.exists?("dump.tar.gz")
      puts "Backup dump.tar.gz not found"
      exit 0
    end
    backup_rb ||= "#{current_path}/lib/backup.rb"
    upload "dump.tar.gz", "#{deploy_to}/etc/dump.tar.gz"
    run "if [ -f #{backup_rb} ]; then ruby #{backup_rb} restore #{deploy_to} ; fi"
  end

  desc "upload database.yml"
  task :upload_database_yaml do
    upload File.join(File.dirname(__FILE__), "database.yml"), "#{shared_path}/database.yml"
    run "ln -s #{shared_path}/database.yml #{release_path}/config/database.yml"
  end

end

Dir[File.join(File.dirname(__FILE__), '..', 'vendor', 'gems', 'hoptoad_notifier-*')].each do |vendored_notifier|
  $: << File.join(vendored_notifier, 'lib')
end

require 'hoptoad_notifier/capistrano'
