App.bookmark_comms = App.cable.subscriptions.create { channel: "BookmarkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    App.bookmark_comms.pingViewCount();

  disconnected: ->
    @perform 'update_view_count'

  received: (data) ->
    if (data.view_count)
      $('#navbar--viewcount').html data.view_count
    if (data.clap)
      App.bookmark_comms.show_clap()

  mark: () ->
    @perform 'mark'

  clap: () ->
    @perform 'clap'

  pingViewCount: () ->
    $('#navbar--viewcount').html '0'
    @perform 'update_view_count'
    setTimeout(App.bookmark_comms.connected,60000)

  show_clap: () ->
    clap_id = Math.floor(Math.random()*5000).toString()
    $("body").prepend("<div id='clap#{clap_id}' class='clap--div'><img class='clap--img' width='35' src='/images/clap.png' /></div>")
    callback = -> unanimate(clap_id)
    setTimeout(callback,10000)


$(document).on 'click', '#bookmark_work', (event) ->
  App.bookmark_comms.mark()
  document.getElementById("bookmark_img").src = "/images/filled_star.png";

$(document).on 'click', '#clap_work', (event) ->
  App.bookmark_comms.clap()
  document.getElementById("clap_img").src = "/images/clap-grey.png"
  document.getElementById("clap_img").style.cursor = "auto"
  setTimeout(ungrey,60000)

ungrey = ->
  document.getElementById("clap_img").src = "/images/clap.png";
  document.getElementById("clap_img").style.cursor = "pointer"

unanimate = (id) ->
  search = "clap" + id
  $("#" + search).remove()
