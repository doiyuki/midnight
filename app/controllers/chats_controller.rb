class ChatsController < ApplicationController
  def index
    # TODO ユーザー名入力させる
    @user_name = 'testing user ex'
    @room_name = $program_name
    gon.room_id = @room_name
  end
end
