class ChatsController < ApplicationController
  def index
    @room_name = $program_name
    gon.room_id = @room_name
  end
end
