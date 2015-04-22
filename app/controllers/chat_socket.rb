class ChatSocket < WebsocketRails::BaseController
  def initialize_session
  end

  def connect_user
  end

  def new_message
    room_id = message[:group_id]
    WebsocketRails["#{room_id}"].trigger(:new_message, message)
  end
end
