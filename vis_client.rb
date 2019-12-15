require_relative 'building.rb'
require_relative 'osm.rb'
require_relative 'parcel.rb'

map = Map.new('data/nhv')

f_out  = File.open("data/parcel_to_building.txt", 'w')

File.open("data/addr_parcels.txt").each do |line|
  p = Parcel.new(line.strip)
  lat = p.coords.lat
  lng = p.coords.lng
  print "#{line.strip}\t"

  feedback = ""
  building = nil 
  
  map.building_ids.each do |b_id|
    b = Building.new(map, b_id)
    
    if b.contains?(p.coords)
      IO.popen("gnuplot", 'w') do |io|
        print b_id

        io.puts "plot '-' w l, '-' pt 5"
        b.pts.each do |pt|
          io.puts "#{pt.lng}, #{pt.lat}"
        end
        io.puts("e")
        io.puts("#{lng}, #{lat}")
        io.puts("e")
        feedback = gets
        building = b_id
      end
    end
  end
  if ! building
    puts "not contained in any building"
    IO.popen("gnuplot", 'w') do |io|
      pad = 0.002
      io.puts "set xrange [#{lng-pad}:#{lng+pad}]"
      io.puts "set yrange [#{lat-pad}:#{lat+pad}]"
      io.puts "plot 'data/buildings.txt' w l lt rgb 'red', '-' pt 5"
      io.puts "#{p.coords.lng}, #{p.coords.lat}"
      io.puts "e"
      feedback = gets
    end
  end
  puts ""
  f_out.write("#{line.strip}\t#{building}\t#{feedback}")
end

f_out.close
#b = Building.new(map, "297837302")
#b.plot_building

