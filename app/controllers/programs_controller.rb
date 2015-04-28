class ProgramsController < ApplicationController
  def index
    @program = Program.new

    area_id = Area
      .where(area_name: $area_name)
      .first()
      .area_id
    uri = URI.parse 'http://radiko.jp/v2/api/program/now?area_id=' + area_id
    response = Net::HTTP.get uri
    xml = Nokogiri::XML response
    @programs = xml
      .xpath('/radiko/stations/station/scd/progs/prog/title')
      .map { |element| element.content }
      .map { |program_title| Program.new(program_name: program_title)}
  end

  def create
    $program_name = get_permitted_params['program_name']

    redirect_to controller: 'chats', action: 'index'
  end

  private
  def get_permitted_params
    params.require(:program).permit(:program_name)
  end
end
