require 'json'
require 'net/http'

key = File.read('api_key.txt').strip

count = 0

File.open('data/uniq_addr.csv').each do |line|
  addr = line.strip.split(',')[1]
  name = addr.gsub(/[^0-9A-Z]/,'_')

  if ! File.exist?("data/addr/#{name}.json")
    puts "getting #{addr}"
    params = {address: "#{addr}, New Haven, CT", key: key}
    uri = URI("https://maps.googleapis.com/maps/api/geocode/json")
    uri.query =  URI.encode_www_form(params)
    
    File.open("data/addr/#{name}.json", "w") do |f|
      resp = Net::HTTP.get(uri)
      data = JSON.parse(resp)
      if data['status'] != "OK"
        puts "warning: request gave status #{data['status']}"
      end
      f.write(resp)
    end
    count += 1

    if count >= 2
      break
    end
    sleep(1)
  end
end
