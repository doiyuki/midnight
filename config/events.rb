WebsocketRails::EventMap.describe do
  subscribe :initialize_session, to: ChatSocket, with_method: :initialize_session
  subscribe :client_connected, to: ChatSocket, with_method: :connect_user
  subscribe :new_message, to: ChatSocket, with_method: :new_message
end
