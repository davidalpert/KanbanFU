$(document).ready ->
  $('.card_list').sortable(
    connectWith: '.card_list'
    stop: (event, ui) ->
      card_id = ui.item.attr('id').match(/\d{1,}$/)
      phase_id = ui.item.parent().parent().attr('id').match(/\d{1,}$/)
      $.ajax(
        type: 'put'
        data: $(ui.item.parent()).sortable('serialize') + '&card_id=' + card_id + '&phase_id=' + phase_id
        dataType: 'script'
        complete: (request) ->
          $(ui.item).effect('highlight')
        url: '/projects/move_card'
      )
  )

  $(".card")
    .addClass("ui-widget ui-widget-content ui-helper-clearfix ui-corner-all")
    .find(".card_header").addClass("ui-widget-header ui-corner-all")
    .prepend('<span class="ui-icon ui-icon-plusthick"></span>')
    .end().find(".card_content")

		$(".card_header .ui-icon").click ->
      $(this).toggleClass("ui-icon-minusthick")
      $(this).parents(".card:first").find(".card_content").toggle()

    $(".card_list").disableSelection()
