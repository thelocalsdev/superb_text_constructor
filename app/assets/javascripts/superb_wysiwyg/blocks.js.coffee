$ ->
  $('.blocks').sortable
    placeholder: "ui-state-highlight"
    update: (event, ui) ->
      blocks = $('.blocks').sortable('toArray')
      $.post $('.blocks').data('reorder-url'), { blocks: blocks }
  $( ".blocks" ).disableSelection()