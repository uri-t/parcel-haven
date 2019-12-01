require_relative 'parcel.rb'
require_relative 'building.rb'
require_relative 'osm.rb'

p = Parcel.new(12115)
pt = p.coords

map = Map.new('data/map.osm')
ids = map.get_building_ids
puts ids.length

ids.each do |id|
  
  b = Building.new(map, id)
  if b.contains?(pt)
    puts("pt contained by building #{id}")
  end
end
