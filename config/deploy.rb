require "bundler/capistrano"
require "rvm/capistrano"
#require "capistrano/ext/multistage"

default_run_options[:pty] = true

set :repository, "git@github.com:bornfree/devroom.git"
set :scm, :git
set :scm_verbose, true

set :user, 'root'
set :deploy_via, :remote_cache

set :migrate_target, :current

set :branch, 'master'

set :application, "devroom"
set :domain, "192.241.218.47"
set :applicationdir, "/home/#{application}"

set :deploy_to, "/home/#{application}"

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :rvm_type, :system
set :rvm_ruby_string, "1.9.3-p448@global"
set :rvm_path, "/usr/local/rvm/"
#set :use_sudo, true
#set :rvm_autolibs_flag, :enable


# if you want to clean up old releases on each deploy uncomment this:
after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
   task :start do ; end
   task :stop do ; end
   task :restart, :roles => :app, :except => { :no_release => true } do
     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
     run "#{try_sudo} chmod 777 #{File.join(current_path,'tmp/')}"
     run "#{try_sudo} chmod 777 #{File.join(current_path,'log/')}"
   end
end