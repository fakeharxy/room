App.bookmark_comms = App.cable.subscriptions.create { channel: "BookmarkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when the subscription has been terminated by the server

  mark: () ->
    @perform 'mark'

$(document).on 'click', '#bookmark_work', (event) ->
  App.bookmark_comms.mark()

