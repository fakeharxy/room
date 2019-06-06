App.work_comms = App.cable.subscriptions.create { channel: "WorkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    App.work_comms.unsubscribe()

  received: (data) ->
    if (data.message && !data.message.blank?)
      $('.message-content').html data.message

  speak: (message, cursorPosition) ->
    @perform 'speak', message: message

  scrollToMiddle: (id) ->
    elem_position = $(id).offset().top;
    window_height = $(window).height();
    y = elem_position - window_height/2;
    window.scrollTo(0,y);

$(document).on 'trix-change', (event) ->
  element = document.querySelector("trix-editor")
  App.work_comms.speak(element.value)
