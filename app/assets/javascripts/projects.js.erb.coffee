$(document).ready ->
  $( "#datepicker" ).datepicker(
    dateFormat: 'M d, yy'
    onSelect: (date, inst) ->
      $.ajax(
        type: 'put'
        data: 'date=' + date
        dataType: 'script'
        url: '/current_date'
      )
  )
	
  $('.card_list').sortable(
    connectWith: '.card_list'
    stop: (event, ui) ->
      phase = ui.item.parent().parent()
      card_id = ui.item.attr('id').match(/\d{1,}$/)
      phase_id = phase.attr('id').match(/\d{1,}$/)
      $.ajax(
        type: 'put'
        data: $(ui.item.parent()).sortable('serialize') + '&card_id=' + card_id + '&phase_id=' + phase_id
        dataType: 'script'
        complete: (request) ->
          $(ui.item).effect('highlight')
        url: '/projects/move_card'
      )
      [2..4].forEach (i) ->
        phase = $("#phase_#{i}")
        wip = phase.attr('wip')
        cards = $("#phase_#{i} > .card_list").children().length
        phase.addClass('wip_limit') if cards > wip
        phase.removeClass('wip_limit') if cards <= wip
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

