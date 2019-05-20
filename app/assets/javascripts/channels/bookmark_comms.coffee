App.bookmark_comms = App.cable.subscriptions.create { channel: "BookmarkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    App.bookmark_comms.pingViewCount();

  disconnected: ->
    @perform 'update_view_count'

  received: (data) ->
    if (data.view_count)
      $('#navbar--viewcount').html data.view_count

  mark: () ->
    @perform 'mark'

  pingViewCount: () ->
    $('#navbar--viewcount').html '0'
    @perform 'update_view_count'
    setTimeout(App.bookmark_comms.connected,60000)

$(document).on 'click', '#bookmark_work', (event) ->
  App.bookmark_comms.mark()
  document.getElementById("bookmark_img").src = "/images/filled_star.png";

