class ChatSocket < WebsocketRails::BaseController
  def initialize_session
  end

  def connect_user
  end

  def new_message
    broadcast_message :new_message, message
  end
end
