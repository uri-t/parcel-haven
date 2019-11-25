require 'net/http'
require 'nokogiri'

class Parcel
  def initialize(pid)
    @pid = pid
  end

  def pid
    @pid
  end
  
  def html
    @html ||= Net::HTTP.get(URI("http://gis.vgsi.com/newhavenct/Parcel.aspx?pid=#{@pid}"))
  end

  def parsed_html
    @parsed_html ||= Nokogiri::HTML(html)
  end

  def owner
    @owner ||= parsed_html.search("//span[@id='MainContent_lblGenOwner']/text()").to_s.tr(",","")
  end

  def appraisal
    @appraisal ||= parsed_html.search("//span[@id='MainContent_lblGenAppraisal']/text()").to_s.tr('^0-9', '')
  end

  def location
    @location ||= parsed_html.search("//span[@id='MainContent_lblLocation']/text()").to_s.tr(",","")
  end
end
