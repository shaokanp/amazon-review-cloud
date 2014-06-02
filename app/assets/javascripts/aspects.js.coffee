# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.currentAspect = ''
window.aspectsArray = [];

$(document).ready(->

  $(document).on('click','#textcloud span', {} , onAspectClick)
  $(document).on('mouseover','#textcloud span', {} , onAspectHover)
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

onAspectHover = (e) ->
  target = e.currentTarget;
  if (!$(target).attr('modifiers'))
    console.log($.grep(window.aspectsArray, (a) -> return a.text == $(target).html())[0])
    m = '';
    $.each($.grep(window.aspectsArray, (a) -> return a.text == $(target).html())[0].modifiers, (index, value) ->
      m = m + value.text + ','
    )
    $(target).attr('modifiers', m);
    $(target).tipsy(
      title: 'modifiers'
      gravity: 'sw'
    )
    $(target).trigger('mouseover')