# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.currentAspect = ''

$(document).ready(->
  $(document).on('click','#textcloud span', {} , onAspectClick)
)

onAspectClick = (e) ->
  target = $(e.currentTarget)
  console.log($('#product-info'))
  window.currentAspect = target.html()
  $.ajax(
    url: '/reviews.js?product_id=' + $('#product-info').find('.product-id').html() + '&keyword=' + window.currentAspect
    success: (data, textStatus, jqXHR)->
      console.log(data)
    error: (jqXHR, textStatus, errorThrown) ->
      console.log('Get aspects error. ' + textStatus)
  )