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
    x = "lng"
    y = "lat"
    
    d = (p2[y]-p1[y])*(p3[x] - p2[x])-(p3[y]-p2[y])*(p2[x] - p1[x])
    if d == 0
      return d
    end
    return d/d.abs
  end
end

#ln1 = GeoLineSeg.new({lon: 0, lat: 0}, {lon: 1, lat: 0})
#ln2 = GeoLineSeg.new({lon: 0, lat: 1}, {lon: 1, lat: 1}) 

#puts(ln2.intersects?(ln1))
