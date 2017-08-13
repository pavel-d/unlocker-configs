require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)
# require 'mina/rvm'    # for rvm support. (https://rvm.io)

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

set :application_name, 'unlocker'
set :domain, '138.197.178.66'
set :user, 'root'
set :deploy_to, '/srv/unlocker-configs'
set :repository, 'https://github.com/pavel-d/unlocker-configs.git'
set :branch, 'master'
set :forward_agent, true

task :environment do
end

task :setup do
end

desc "Deploys the current version to the server."
task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :render_config
    invoke :link_config
    invoke :restart
  end
end

task :render_config do
  command 'rake render_config'
end

task :link_config do
  command 'cp config/smart-proxy/* /etc/smart-proxy'
  command 'cp config/bind/* /etc/bind/'
end

task :restart do
  command 'sv restart smart-proxy'
  command 'service bind9 reload'
end
