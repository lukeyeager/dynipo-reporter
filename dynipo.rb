require 'logger'
require 'net/http'

#log = Logger.new(STDOUT)
log = Logger.new('/tmp/dynipo.log', 'weekly')
log.level = Logger::DEBUG

if ARGV.empty?
	#host = 'localhost:3000'
	host = 'dynipo.herokuapp.com'
	server_name = ''
	password = ''

elsif ARGV.count == 3
	host = ARGV[0]
	server_name = ARGV[1]
	password = ARGV[2]

else
	puts "Usage:
  dynipo.rb host server_name password

Examples:
    dynipo.rb dynipo.com minecraft Password123
    dynipo.rb 127.0.0.1:3000 fileserver Password123"
	exit
end

log.debug "Reporting #{server_name} to #{host}..."

uri = URI("http://#{host}/update")
params = {
		:name => server_name,
		:password => password
	}
uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)

log.info 'Code: ' + res.code
log.debug 'Msg: ' + res.msg
log.debug 'Body: ' + res.body
