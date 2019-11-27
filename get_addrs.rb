require 'sqlite3'
require 'net/http'

key = File.read('api_key.txt').strip

File.open('addr_test.txt').each do |line|
  name = line.strip.gsub(/[^0-9A-Z]/,'_')
  params = {address: "#{line.strip}, New Haven, CT", key: key}
  uri = URI("https://maps.googleapis.com/maps/api/geocode/json")
  uri.query =  URI.encode_www_form(params)

  File.open("data/addr/#{name}.json", 'w') do |f|
    f.write(Net::HTTP.get(uri))
  end
end
  
