require 'erb'

DYMAMIC_CONFIGS = %w(./config/sniproxy/sniproxy.conf ./config/bind/zones.override)

task :render_config do
  @host_names = File.open('./dump.csv', 'r:windows-1251').read.lines.drop(1)
                .map { |line| line.split(';')[1].chomp('.') }.uniq

  @host_names << '2ip.ru'

  puts "Processing #{@host_names.count} forbidden host names"

  DYMAMIC_CONFIGS.each do |config_file|
    File.open(config_file, 'w') do |file|
      file.write(ERB.new(File.open("#{config_file}.erb").read).result(binding))
    end
  end
end
