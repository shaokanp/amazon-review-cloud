# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

batchLoadNum = 10
window.currentAspect = ''
loadTimes = 0
isLastLoadFinished = true
window.isAllReviewLoaded = false
window.aspectsArray = [];

$(document).ready(->

  $(document).on('click','#textcloud span', {} , onAspectClick)
  $(document).on('mouseover','#textcloud span', {} , onAspectHover)
  $(document).on('mouseleave','#textcloud span', {} , onAspectMouseLeave)

  $(window).scroll(() ->
    if(window.currentTask == 'review' && loadTimes >= 1 && isLastLoadFinished && !window.isAllReviewLoaded)
      if($(window).scrollTop() + $(window).height() > $(document).height() - 50)
        loadReviews(loadTimes*batchLoadNum)
  )
)

onAspectClick = (e) ->
  isLastLoadFinished = false
  window.isAllReviewLoaded = false
  target = $(e.currentTarget)
  window.currentTask = 'review'
  loadTimes = 0
  window.currentAspect = target.html()
  $('#review-list').empty()

  loadReviews(loadTimes*batchLoadNum)

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

  $('#modifier-toolkit').css('top', (parseInt($(target).css('top')) - 40 + $('#textcloud').offset().top) + 'px')
  $('#modifier-toolkit').css('left', (parseInt($(target).css('left')) + 20  + $('#textcloud').offset().left) + 'px')
  $('#modifier-toolkit').children('span').html($(target).attr('modifiers'))
  $('#modifier-toolkit').show()

onAspectMouseLeave = (e) ->
  $('#modifier-toolkit').hide()

loadReviews = (since)->
  console.log('since: ' + since)
  $.ajax(
    url: '/reviews.js?since=' + since + '&product_id=' + $('#product-info').find('.product-id').html() + '&keyword=' + window.currentAspect
    success: (data, textStatus, jqXHR)->
      loadTimes = loadTimes + 1
      isLastLoadFinished = true
    error: (jqXHR, textStatus, errorThrown) ->
      isLastLoadFinished = true
      console.log('Get aspects error. ' + textStatus)
  )