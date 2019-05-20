App.work_comms = App.cable.subscriptions.create { channel: "WorkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    App.work_comms.unsubscribe()

  received: (data) ->
    if (data.message && !data.message.blank?)
      $('.message-content').html data.message

  speak: (message) ->
    @perform 'speak', message: message

$(document).on 'keyup', '#message_content', (event) ->
  App.work_comms.speak event.target.value
