require 'mina/git'

set :domain, '46.101.255.49'
set :user, 'root'
set :repository, 'git@github.com:pavel-d/unlocker-proxy.git'
set :deploy_to, '/srv/unlocker-proxy'
set :forward_agent, true

DYMAMIC_CONFIGS = %w(config/sniproxy/sniproxy.conf config/bind/zones.override)

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :fetch_dump
    invoke :render_config
    invoke :link_config
    invoke :restart
  end
end

task :fetch_dump do
  queue 'wget https://raw.githubusercontent.com/zapret-info/z-i/master/dump.csv'
end

task :render_config do
  queue 'rake render_config'
end

task :link_config do
  queue 'ln -s config/sniproxy/* /etc/'
  queue 'ln -s config/bind/* /etc/bind/'
end

task :restart do
  queue 'killall -HUP sniproxy'
  queue 'service bind9 reload'
end
