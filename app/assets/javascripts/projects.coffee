# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.btn-new-project').click (e) -> 
    e.preventDefault();
    $(this).hide();
    $('form.new_project').show()
  
  $('a.cancel-project').on 'click', (e) ->
    e.preventDefault()
    $("form.new_project").hide()
    $('.btn-new-project').show()

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)