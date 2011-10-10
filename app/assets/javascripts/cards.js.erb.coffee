# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$(".block_card").click (e) -> 
      e.preventDefault()
      target = $(this).parent().parent()
      original_href = this.href
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
        url: original_href
        dataType: 'script'
        complete: (request) ->
	      # nothing to do
      )
      false

	$(".ready_card").click (e) -> 
      e.preventDefault()
      target = $(this).parent().parent()
      original_href = this.href
      isReady = this.href.indexOf('not_ready') >= 0

      if isReady
        this.href = this.href.replace('not_', '')
        $(this).text('Ready')
        target.removeClass('ready')
      else
        this.href = this.href.replace('ready', 'not_ready')
        $(this).text('Not Ready')
        target.addClass('ready')

      $.ajax(
        type: 'put'
        url: original_href
        dataType: 'script'
        complete: (request) ->
	      # nothing to do
      )
      false




