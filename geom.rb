class Point
  attr_accessor :lat, :lng
  def initialize(pt_hash)
    if ! pt_hash.include?(:lng) && pt_hash.include?(:lat)
      raise 'please specify both longitude (:lng) and latitude (:lat)'
    end
    @lat = pt_hash[:lat]
    @lng = pt_hash[:lng]
  end
end

class BoundingBox
  attr_accessor  :min_lat, :max_lat, :min_lng, :max_lng
  def initialize(min_lat, max_lat, min_lng, max_lng)
    @min_lat = min_lat
    @max_lat = max_lat
    @min_lng = min_lng
    @max_lng = max_lng
  end

  def in_box?(pt)
    pt
  end
end

class KdBBNode
  def initialize(building_id, bb)
    @building_id = building_id

    @bounding_box = bb
    @left = nil
    @right = nil
    @middle = nil
    @axis = d
  end

  def insert(node)
  end

  # expects pts to be hash with keys "lat" and "lng"
  def bb_contains(pt)
  end

  # expects pts to be hash with keys "lat" and "lng"
  def find_contained(pt, results)
  end
      
end
