class ProgramsController < ApplicationController
  def index
    @test_area_name = $area_name

    area_id = Area
      .where(area_name: $area_name)
      .first()
      .area_id
    uri = URI.parse 'http://radiko.jp/v2/api/program/now?area_id=' + area_id
    response = Net::HTTP.get uri
    xml = Nokogiri::XML response
    programTitles = xml
      .xpath('/radiko/stations/station/scd/progs/prog/title')
      .map { |element| element.content }
    @titles = programTitles
  end
end
