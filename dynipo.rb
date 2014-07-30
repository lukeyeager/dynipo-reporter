require 'logger'
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
	:admin_password => 'password',
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

#log = Logger.new(STDOUT)
log = Logger.new(File.join(__dir__, 'log/dynipo.log'), 'weekly')
log.level = Logger::DEBUG

uri = URI("http://#{config[:hostname]}/update")
params = {
		:name => config[:server_name],
		:password => config[:admin_password],
	}
uri.query = URI.encode_www_form(params)

log.debug "URL: #{uri}"

res = Net::HTTP.get_response(uri)

log.info 'Code: ' + res.code
log.debug 'Msg: ' + res.msg
log.debug 'Body: ' + res.body
