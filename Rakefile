require 'erb'
require 'yaml'

DYMAMIC_CONFIGS = %w(config/smart-proxy/settings.yml config/bind/zones.override)

task :render_config do
  @host_names = YAML.load(File.read('./config/settings.yml'))['proxy_hosts'].uniq!

  puts "Processing #{@host_names.count} host names"

  DYMAMIC_CONFIGS.each do |config_file|
    File.open(config_file, 'w:utf-8') do |file|
      puts "Rendering #{config_file}"
      file.write(ERB.new(File.open("#{config_file}.erb").read).result(binding))
    end
  end

  puts 'Done rendering configs'
end
