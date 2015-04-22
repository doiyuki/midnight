class @Socket
  constructor: (url, useWebsocket) ->
    @room_id = gon.room_id
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @channel = @dispatcher.subscribe(@room_id)
    @bindEvents()

  bindEvents: () =>
    $('#send').on 'click', @sendMessage
    @dispatcher.bind 'new_message', @receiveMessage
    @channel.bind 'new_message', @receiveMessage

  sendMessage: (event) =>
    user_name = $('#username').text()
    message_body = $('#message_body').val()
    @dispatcher.trigger 'new_message',
      { name: user_name, body: message_body, group_id: @room_id }
    $('#message_body').val('')

  receiveMessage: (message) ->
    $('#chat').append "#{message.name} 「#{message.body}」<br/>"

class @ChatsController
  index: ->
    window.socket = new Socket($('#chat').data('uri'), true)
