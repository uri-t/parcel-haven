require_relative 'geom.rb'
require_relative 'osm.rb'
require_relative 'line_seg.rb'

class Building
  def initialize(map, id)
    @map = map
    @id = id
  end

  def nds
     if ! @nds
       @map.building_nodes
    end
    @nds ||= @map.building_nodes[@id]
    return @nds
  end

  def pts
    if ! @pts
      nds
    end
    @pts ||= nds.map {|x| @map.node_dict[x]}
  end

  def contains?(pt)
    #TODO add simple bounding box test case
    #TODO finish intersection counting code (constructing list of lines...)
    o = Point.new({lat: 0, lng: 0})
    ln = GeoLineSeg.new(o, pt)

    lns = []

    # build array of lines that make up building polygon
    (0..pts.length-2).each do |i|
      lns << GeoLineSeg.new(pts[i], pts[i+1])
    end

    #count intersections
    i_count = 0
    lns.each do |lin|
      if lin.intersects?(ln)
        i_count += 1
      end
    end
    if i_count % 2 == 0
      return false
    end
    return true
    end

end

def test
  map = Map.new('data/nhv')
  map.building_nodes
  b = Building.new(map, "39242811")
  strt = Time.now
  nds =  b.nds
  elap = Time.now-strt
  puts nds
  puts "#{elap} s for nds call"

  puts b.pts.map {|p| p.lng}
end

#test
