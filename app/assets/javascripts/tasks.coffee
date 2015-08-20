# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
ready = ->
  $('.best_in_place').best_in_place()

  $(document).on('mouseover', '.task-name', (e) ->
    e.preventDefault();
    $('.edit-task', this).add('.delete-task', this)
      .add('.up-task', this)
      .add('.down-task', this).show());

  $(document).on('mouseout', '.task-name', (e) ->
    e.preventDefault();
    $('.edit-task', this).add('.delete-task', this)
      .add('.up-task', this)
      .add('.down-task', this).hide());

  $(document).on('click', '.edit-task', (e) ->
    e.preventDefault();
    task_id = $(this).data('taskId')
    $('#best_in_place_task_' + task_id + '_name').click());

  $(document).on('click', '.edit-answer-link', (e) ->
    e.preventDefault();
    $(this).hide();
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show())

  $(document).on('change', '#status', (e) ->
    e.preventDefault();
    project = $('.status_check_box').data('projectId')
    $.ajax
      url: '/projects/' + project + '/tasks/' + @value
      type: 'PATCH'
      data: task: 'status': @checked)

$(document).ready(ready)
$(document).on('page:load', ready)
$(document).on('page:update', ready)