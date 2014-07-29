require 'net/http'

host = 'localhost:3000'
#host = 'dynipo.herokuapp.com'
server_name = 'minecraft'
password = 'luke'

uri = URI("http://#{host}/server/#{server_name}.json?password=#{password}")
res = Net::HTTP.get_response(uri)

puts 'Code: ' + res.code
puts 'Msg: ' + res.msg
puts 'Body: ' + res.body
