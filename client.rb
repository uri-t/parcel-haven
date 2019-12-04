require_relative 'parcel.rb'
require_relative 'building.rb'
require_relative 'osm.rb'

p = Parcel.new(12115)
pt = p.coords

map = Map.new('data/nhv')
ids = map.building_ids
puts ids[0].class

strt = Time.now

ids.each_with_index do |id, ind|
  b = Building.new(map, id)
  
  if b.contains?(pt)
    puts("pt contained by building #{id}")
  end
end
