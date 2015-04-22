class ChatsController < ApplicationController
  def index
    # TODO ユーザー名入力させる
    @user_name = 'testing user ex'
    @room_name = get_permitted_params['program']
    gon.room_id = @room_name
  end

  private
  def get_permitted_params
    params.permit(:program)
  end
end
