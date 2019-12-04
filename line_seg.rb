require_relative 'geom.rb'

class GeoLineSeg

  attr_accessor :p1
  attr_accessor :p2
  
  def initialize(p1, p2)
    @p1 = p1
    @p2 = p2
  end
  
  def intersects?(ln)
    # TODO: should probably check collinear case
    if GeoLineSeg::orientation(@p1, @p2, ln.p1) == GeoLineSeg::orientation(@p1, @p2, ln.p2)
      return false
    end

    if GeoLineSeg::orientation(ln.p1, ln.p2, @p1) == GeoLineSeg::orientation(ln.p1, ln.p2, @p2)
      return false
    end
    return true
  end

  def self.orientation(p1, p2, p3)
    
    d = (p2.lat-p1.lat)*(p3.lng - p2.lng)-(p3.lat-p2.lat)*(p2.lng - p1.lng)
    if d == 0
      return d
    end
    return d/d.abs
  end
end

def test
  p1 = Point.new({lng: 0, lat: 0})
  p2 = Point.new({lng: 1, lat: 1})
  p3 = Point.new({lng: 0, lat: 1})
  p4 = Point.new({lng: 1, lat: 0})

  ln1 = GeoLineSeg.new(p1, p2)
  ln2 = GeoLineSeg.new(p3, p4)

  puts(ln2.intersects?(ln1))
end

#test
