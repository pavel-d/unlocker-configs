require 'erb'
require 'yaml'
require 'simpleidn'

DYMAMIC_CONFIGS = %w(config/smart-proxy/settings.yml config/bind/zones.override)

task :render_config do
  additional_host_names = YAML.load(File.read('./config/settings.yml'))['proxy_hosts']

  @host_names = File.open('./dump.csv', 'r:windows-1251').read.lines.drop(1)
                .map { |line| SimpleIDN.to_ascii(line.split(';')[1].chomp('.')) } + additional_host_names
  @host_names.uniq!

  puts @host_names.last
  puts "Processing #{@host_names.count} host names"

  DYMAMIC_CONFIGS.each do |config_file|
    File.open(config_file, 'w:utf-8') do |file|
      puts "Rendering #{config_file}"
      file.write(ERB.new(File.open("#{config_file}.erb").read).result(binding))
    end
  end

  puts 'Done rendering configs'
end
