require_relative 'osm.rb'

class Building
  def initialize(map, id)
    @map = map
    @id = id
  end

  def nds
    @nds ||= @map.doc.search('//way[@id=17211543]/nd/@ref').map {|x| x.value}
  end

  def pts
    @pts ||= nds.map {|x| @map.node_dict[x]}
  end
end

