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
    user_name = $('#user_name').val()
    message_body = $('#message_body').val()
    @dispatcher.trigger 'new_message',
      { name: user_name, body: message_body, group_id: @room_id }
    $('#message_body').val('')

  receiveMessage: (message) ->
    $('#chat').append "#{message.name} 「#{message.body}」<br/>"
    timeline_area = $('#timeline-area')
    timeline_area.animate({ scrollTop: timeline_area.height() })

class @ChatsController
  index: ->
    window.socket = new Socket($('#chat').data('uri'), true)

    # To protect submitting by enter-key without css class named 'allow_submit'.
    $(document).on 'keypress',
      '#message_body',
      (event) ->
        enterKeyNumber = 13
        isKeyEnter = event.keyCode == enterKeyNumber
        $('#send').trigger('click') if isKeyEnter
