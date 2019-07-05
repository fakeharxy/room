localStorage.setItem("tweet", "true")
App.work_comms = App.cable.subscriptions.create { channel: "WorkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    App.work_comms.unsubscribe()

  received: (data) ->
    if (data.message && !data.message.blank?)
      $('.message-content').html data.message
      if $('#scrollCheck').is(":checked")
        App.work_comms.scrollToMiddle("#scrollPos")

  speak: (message) ->
    @perform 'speak', message: message

  tweet: () ->
    @perform 'tweet'
    
  scrollToMiddle: (id) ->
    elem_position = $(id).offset().top;
    window_height = $(window).height();
    y = elem_position - window_height/2;
    window.scrollTo(0,y);

$(document).on 'keyup', '#trix-editor',  (event) ->
  element = document.querySelector("trix-editor")
  range = element.editor.getSelectedRange()
  if range[0] == range[1]
    element.editor.insertString("~")
    if localStorage.getItem("tweet") == 'true'
      App.work_comms.tweet()
      localStorage.setItem("tweet", "false")
    App.work_comms.speak(element.value)
    element.editor.deleteInDirection("backward")

$(document).on 'click', '#trix-toolbar-1',  (event) ->
  element = document.querySelector("trix-editor")
  App.work_comms.speak(element.value)

setCookie = (cname, cvalue, exdays) ->
  d = new Date
  d.setTime d.getTime() + exdays * 24 * 60 * 60 * 1000
  expires = 'expires=' + d.toUTCString()
  document.cookie = cname + '=' + cvalue + ';' + expires + ';path=/'
  return
