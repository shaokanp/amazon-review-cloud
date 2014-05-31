# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->
  window.location.hash = ''
  $(document).on('click','.product-cell', {} , onProductClick)
  $(window).on('navigate',(event, data) ->
      direction = data.state.direction
      if(direction == 'back')
        $('#product-list').show()
        $('#product-show').hide()
      if(direction == 'forward')
        $('#product-list').hide()
        $('#product-show').show()
  )
)

onProductClick = (e) ->
  $.ajax(
    url: '/products/' + $(e.currentTarget).children('.product-id').html() + '.js'
    success: (data, textStatus, jqXHR)->
      console.log(data)
    error: (jqXHR, textStatus, errorThrown) ->
      console.log('Get aspects error. ' + textStatus)
  )

