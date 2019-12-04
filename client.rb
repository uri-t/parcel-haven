require_relative 'parcel.rb'
require_relative 'building.rb'
require_relative 'osm.rb'

p = Parcel.new(12115)
pt = p.coords

map = Map.new('data/map.osm')
ids = map.building_ids
puts ids.length

strt = Time.now

ids.each_with_index do |id, ind|
  if ind % 20 == 0 
    puts "building no. #{ind}: #{Time.now-strt} seconds elapsed"
  end
  b = Building.new(map, id)
  if b.contains?(pt)
    puts("pt contained by building #{id}")
  end
end
