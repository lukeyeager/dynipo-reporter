require 'net/http'
require 'yaml'

config_file = File.join(__dir__, 'config.yml')

if File.exists?(config_file)
	config = YAML::load_file(config_file)
else
	config = Hash.new
end

defaults = {
	:hostname => 'localhost',
	:server_name => 'myserver',
	:password => 'password',
}.each do |param, default|

	if !config.include?(param)
		puts "Input #{param} (default '#{default}'):"
		val = gets.chomp
		config[param] = val.empty? ? default : val
		puts "  #{param} = '#{config[param]}'"
	end

end

#puts config.inspect
File.write(config_file, YAML.dump(config) )

puts uri = URI("http://#{config[:hostname]}/server/#{config[:server_name]}.json?password=#{config[:password]}")
res = Net::HTTP.get_response(uri)

puts 'Code: ' + res.code
puts 'Msg: ' + res.msg
puts 'Body: ' + res.body
