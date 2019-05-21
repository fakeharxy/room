App.work_comms = App.cable.subscriptions.create { channel: "WorkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    App.work_comms.unsubscribe()

  received: (data) ->
    if (data.message && !data.message.blank?)
      $('.message-content').html data.message
      App.work_comms.scrollToMiddle("#scrollPos");

  speak: (message, cursorPosition) ->
    @perform 'speak', message: message, cursor_position: cursorPosition

  scrollToMiddle: (id) ->
    elem_position = $(id).offset().top;
    window_height = $(window).height();
    y = elem_position - window_height/2;
    window.scrollTo(0,y);

$(document).on 'keyup', '#message_content', (event) ->
  App.work_comms.speak(event.target.value, $('#message_content').prop("selectionEnd"))
