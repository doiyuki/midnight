require 'net/http'
require 'uri'
require 'nokogiri'

class AreasController < ApplicationController
  def index
    @area = Area.new
  end

  def create
    $area_name = get_permitted_params['area_name']

    redirect_to controller: 'programs', action: 'index'
  end

  private
  def get_permitted_params
    params.require(:area).permit(:area_name)
  end

end
