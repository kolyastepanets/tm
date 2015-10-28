# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.best_in_place').best_in_place()

  $('.btn-new-project').click (e) ->
    e.preventDefault();
    $(this).hide();
    $('form.new_project').slideDown()

  $('a.cancel-project').on 'click', (e) ->
    e.preventDefault()
    $("form.new_project").slideUp()
    $('.btn-new-project').slideDown()

  $('.black-cross').on 'click', (e) ->
    e.preventDefault()
    $(".notifications").slideUp()

  $(document).on('mouseover', '.project-name', (e) ->
    e.preventDefault();
    $('.edit-project', this).add('.delete-project', this).show());

  $(document).on('mouseout', '.project-name', (e) ->
    e.preventDefault();
    $('.edit-project', this).add('.delete-project', this).hide());

  $(document).on('click', '.edit-project', (e) ->
    e.preventDefault();
    project_id = $(this).data('projectId')
    $('#best_in_place_project_' + project_id + '_name').click());

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)