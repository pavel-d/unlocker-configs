require 'mina/git'

set :domain, '46.101.255.49'
set :user, 'root'
set :repository, 'git@github.com:pavel-d/unlocker-configs.git'
set :deploy_to, '/srv/unlocker-configs'
set :forward_agent, true

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :fetch_dump
    invoke :render_config
    invoke :link_config
    invoke :restart
    invoke :'deploy:cleanup'
  end
end

task :fetch_dump do
  queue 'wget https://raw.githubusercontent.com/zapret-info/z-i/master/dump.csv'
end

task :render_config do
  queue 'rake render_config'
end

task :link_config do
  queue 'cp config/smart-proxy/* /etc/smart-proxy'
  queue 'cp config/bind/* /etc/bind/'
end

task :restart do
  queue 'sv restart smart-proxy'
  queue 'service bind9 reload'
end
