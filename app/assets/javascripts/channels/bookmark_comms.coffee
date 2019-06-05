App.bookmark_comms = App.cable.subscriptions.create { channel: "BookmarkCommsChannel", work: window.location.pathname.split("/")[2] },
  connected: ->
    App.bookmark_comms.pingViewCount();

  disconnected: ->
    @perform 'update_view_count'

  received: (data) ->
    if (data.view_count)
      $('#navbar--viewcount').html data.view_count
    if (data.clap)
      App.bookmark_comms.show_clap(data.clap)

  mark: () ->
    @perform 'mark'

  clap: (clapColour) ->
    @perform 'clap', clapColour: clapColour

  pingViewCount: () ->
    $('#navbar--viewcount').html '0'
    @perform 'update_view_count'
    setTimeout(App.bookmark_comms.connected,60000)

  show_clap: (clapColour) ->
    clap_id = Math.floor(Math.random()*5000).toString()
    $("body").prepend("<div id='clap#{clap_id}' class='clap--div'><img class='clap--img' width='35' src='/images/clap-#{clapColour}.png' /></div>")
    callback = -> unanimate(clap_id)
    setTimeout(callback,10000)

$(window).load ->
  grey()

$(document).on 'click', '#bookmark_work', (event) ->
  App.bookmark_comms.mark()
  document.getElementById("bookmark_img").src = "/images/filled_star.png";

$(document).on 'click', '#clap_work', (event) ->
  if document.getElementById("clap_img").style.cursor == "pointer"
    colour = event.target.getAttribute('data-id')
    App.bookmark_comms.clap(colour)
    grey()

ungrey = (colour) ->
  document.getElementById("clap_img").src = "/images/clap-#{colour}.png";
  document.getElementById("clap_img").style.cursor = "pointer"

grey = ->
  event = document.getElementById("clap_img")
  event.src = "/images/clap-grey.png"
  event.style.cursor = "auto"
  colour = event.getAttribute('data-id')
  callback = -> ungrey(colour)
  setTimeout(callback,10000)

unanimate = (id) ->
  search = "clap" + id
  $("#" + search).remove()
