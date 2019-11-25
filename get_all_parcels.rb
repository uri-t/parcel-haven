require_relative 'parcel.rb'

fout = File.open("all_parcels.csv", 'w')

fout.write("pid,location,owner,appraisal\n")
File.open("pids.txt").each do |pid|
  p = Parcel.new(pid.strip)
  puts "#{p.pid},#{p.location},#{p.owner},#{p.appraisal}\n"
  fout.write("#{p.pid},#{p.location},#{p.owner},#{p.appraisal}\n")
  sleep(0.1)
end

  
  
