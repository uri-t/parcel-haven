require 'net/http'
require 'nokogiri'


def get_streets
  all_links = []
  ('A'..'Z').each do |c|
    resp = Net::HTTP.get("gis.vgsi.com", "/newhavenct/Streets.aspx?Letter=#{c}")
    parsed = Nokogiri::HTML(resp)
    all_links += parsed.search("//ul[@id='list']/li/a/@href")
    sleep(0.2)
  end

  return all_links.map { |x| x.to_s}
end

def get_parcels(link)
  resp = Net::HTTP.get(URI("http://gis.vgsi.com/newhavenct/#{link}"))

  parsed = Nokogiri::HTML(resp)
  data = parsed.search("//ul[@id='list']/li/a/@href").map{ |x| x.to_s}
  puts "#{link} has #{data.length} parcels"
  sleep(0.2)
  return data
end

def test_parcels()
  strt = get_streets.sample
  puts "#{strt} has #{get_parcels(strt).length} parcels"
end


def get_all_parcels()
  parcels = []
  get_streets.each do |st|
    parcels += get_parcels(st)
  end
  return parcels
end

def write_all_parcels(fname)
  open(fname, 'w') do |f|
    get_all_parcels.each do |p|
      f.write("#{p}\n")
    end
  end
end

write_all_parcels('parcels.txt')
