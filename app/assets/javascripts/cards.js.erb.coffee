# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->
	$(".block_card").click (e) -> 
      e.preventDefault()
      target = $(this).parent().parent()
      blockIt = this.href.indexOf('unblock') < 0
      if blockIt
        target.addClass('blocked')
      else
        target.removeClass('blocked')
      #alert('Should blockit? ' +  blockIt)      
      $.ajax(
        type: 'put'
        url: this.href
        dataType: 'script'
        complete: (request) ->
	      # change class to be 
          #alert('Ajax call complete ' + c)
      )
      false




