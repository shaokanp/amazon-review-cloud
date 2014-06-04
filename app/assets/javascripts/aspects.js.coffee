# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.currentAspect = ''
window.aspectsArray = [];

$(document).ready(->

  $(document).on('click','#textcloud span', {} , onAspectClick)
  $(document).on('mouseover','#textcloud span', {} , onAspectHover)
  $(document).on('mouseleave','#textcloud span', {} , onAspectMouseLeave)
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

  $('#modifier-list').empty()
  $.each($.grep(window.aspectsArray, (a) -> return a.text == target.html())[0].modifiers, (index, value) ->
    $('#modifier-list').append('<div class="modifier-tag"><span>' + value.text + '</span></div>')
  )

  console.log($("#modifier-list").offset().top)
  $('html, body').animate({
    scrollTop: $("#modifier-list").offset().top
  }, 600);

onAspectHover = (e) ->
  target = e.currentTarget;
  if (!$(target).attr('modifiers'))
    m = '';
    $.each($.grep(window.aspectsArray, (a) -> return a.text == $(target).html())[0].modifiers, (index, value) ->
      if(index < 5)
        m = m + value.text + ', '
    )
    m = m + '...'
    $(target).attr('modifiers', m)
#    $(target).tipsy(
#      title: 'modifiers'
#      gravity: 'sw'
#    )
#    $(target).trigger('mouseover')

  $('#modifier-toolkit').css('top', (parseInt($(target).css('top')) - 40 + $('#textcloud').offset().top) + 'px')
  $('#modifier-toolkit').css('left', (parseInt($(target).css('left')) + 20  + $('#textcloud').offset().left) + 'px')
  $('#modifier-toolkit').children('span').html($(target).attr('modifiers'))
  $('#modifier-toolkit').show()

onAspectMouseLeave = (e) ->
  $('#modifier-toolkit').hide()