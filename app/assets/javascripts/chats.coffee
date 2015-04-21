class @Socket
  constructor: (url, useWebsocket) ->
    console.log("constructor")
    @dispatcher = new WebSocketRails(url, useWebsocket)
    @bindEvents()

  bindEvents: () =>
    console.log("bindEvents")
    $('#send').on 'click', @sendMessage
    @dispatcher.bind 'new_message', @receiveMessage

  sendMessage: (event) =>
    console.log("sendMessage")
    user_name = $('#username').text()
    message_body = $('#message_body').val()
    @dispatcher.trigger 'new_message', { name: user_name, body: message_body }
    $('#message_body').val('')

  receiveMessage: (message) ->
    console.log("receiveMessage")
    $('#chat').append "#{message.name} 「#{message.body}」<br/>"

class @ChatsController
  index: ->
    console.log("index")
    window.socket = new Socket($('#chat').data('uri'), true)
