require 'nokogiri'

class Map
  def initialize(fname)
    @doc = File.open(fname) do |f|
      Nokogiri::XML(f)
    end
  end

  def doc
    @doc
  end
  
  def raw_nodes
    @raw_nodes ||= doc.search('//node')
  end

  def node_dict
    if ! @node_dict
      @node_dict = Hash.new
      raw_nodes.each do |nd|
        lat = nd.attributes['lat'].value.to_f
        lon = nd.attributes['lon'].value.to_f
        id = nd.attributes['id'].value
        
        @node_dict[id] = Hash[:lat, lat, :lon, lon]
      end
    end
    
    return @node_dict
  end
  
  def raw_ways
    @raw_ways ||= doc.search('//way')
  end

  def get_building_pts
    raw_ways.each do |way|
      tag_names = way.search("tag").map {|x| x.attributes['k'].value}
      if tag_names.include?("building")
        nds = way.search("nd").map {|x| x.attributes['ref'].value}
        nds.each do |nd|
          puts "#{node_dict[nd][:lon]}, #{node_dict[nd][:lat]}"
        end
        puts ""
      end
    end
  end
      
end
