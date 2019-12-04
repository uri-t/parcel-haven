require 'net/http'
require 'nokogiri'
require 'cgi'
require 'json'
require_relative 'geom.rb'
class Parcel
  def initialize(pid)
    @pid = pid
  end

  def pid
    @pid
  end
  
  def html
    if @html
      return @html
    else
      filename = "data/html/#{@pid}.html"
      if File.file?(filename)
        @html = File.read(filename)
      else
        @html = Net::HTTP.get(URI("http://gis.vgsi.com/newhavenct/Parcel.aspx?pid=#{@pid}"))
      end
    end
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(html)
  end

  def owner
    @owner ||= CGI.unescapeHTML(parsed_html.search("//span[@id='MainContent_lblGenOwner']/text()").to_s.tr(",",""))
  end

  def appraisal
    @appraisal ||= parsed_html.search("//span[@id='MainContent_lblGenAppraisal']/text()").to_s.tr('^0-9', '')
  end

  def location
    @location ||= CGI.unescapeHTML(parsed_html.search("//span[@id='MainContent_lblLocation']/text()").to_s.tr(",",""))
  end

  def coords
    if ! @coords
      raw_hash = JSON.parse(File.read("data/addr/#{location.gsub(/[^0-9A-Z]/,'_')}.json"))['results'][0]['geometry']['location']
      @coords = Point.new({lat: raw_hash['lat'], lng: raw_hash['lng']})
    end
    return @coords
  end
end


p = Parcel.new(12116)
puts p.coords
