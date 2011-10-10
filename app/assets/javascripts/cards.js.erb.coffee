# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$(".block_card").click (e) -> 
      e.preventDefault()
      target = $(this).parent().parent()
      isBlocked = this.href.indexOf('unblock') >= 0

      if isBlocked
        this.href = this.href.replace('unblock', 'block')
        $(this).text('Block')
        target.removeClass('blocked')
      else
        this.href = this.href.replace('block', 'unblock')
        $(this).text('Unblock')
        target.addClass('blocked')

      $.ajax(
        type: 'put'
        url: this.href
        dataType: 'script'
        complete: (request) ->
	      # nothing to do
      )
      false




