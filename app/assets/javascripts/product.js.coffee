# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->
  $(document).on('click','.product-cell', {} , onProductClick)
)

onProductClick = (e) ->
  console.log($(e.currentTarget).children('.product-id').html())
  $.ajax(
    url: '/aspects.js'
    data:
      product_id: $(e.currentTarget).children('.product-id').html()
    success: (data, textStatus, jqXHR)->
      console.log(data)
    error: (jqXHR, textStatus, errorThrown) ->
      console.log('Get aspects error. ' + textStatus)
  )

