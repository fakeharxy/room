# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('.card-bookmark').on "click", (event) ->
    id = event.target.getAttribute('data-id')
    $.ajax
      url: "/unbookmark/#{id}",
      headers:
        'X-Transaction': 'POST',
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      method: 'POST'
    event.target.remove()
    event.preventDefault()
