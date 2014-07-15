require 'net/http'

if ARGV.count < 3
	puts "Usage:
  dynipo.rb host server_name password

Examples:
    dynipo.rb dynipo.com minecraft Password123
    dynipo.rb 127.0.0.1:3000 fileserver Password123"
	exit
end

host = ARGV[0]
puts "  host:
    #{host}"
server_name = ARGV[1]
puts "  server_name:
    #{server_name}"
password = ARGV[2]
puts "  password:
    #{password}"

server_name = 'minecraft'
password = 'admin'

uri = URI("http://#{host}/update")
params = {
		:name => server_name,
		:password => password
	}
uri.query = URI.encode_www_form(params)
res = Net::HTTP.get_response(uri)
puts res.body
