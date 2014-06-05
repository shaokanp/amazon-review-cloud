# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

batchLoadNum = 15
loadTimes = 0
isLastLoadFinished = true
window.isAllLoaded = false
window.searchKeyword = ''
window.currentTask = 'search'
history.pushState({},'', '#home')

$(document).ready(->
  $(document).on('click','.product-cell', {} , onProductClick)

  window.onpopstate = (event)->
    if(location.hash != '#home')
      $('#product-list').show()
      $('#product-list').masonry('reload');
      $('#product-show').hide()
    else
      location.reload()

    event.preventDefault()
    event.stopPropagation()
    return false


  $('input[name=authenticity_token]').attr('value', $('meta[name=csrf-token]').attr('content'))
  $('#search-box input[name=submit]').click(onSearchSubmit)
  $(window).keydown((event) ->
      if(event.keyCode == 13)
        $('#search-box input[name=submit]').trigger('click')
        event.preventDefault()
        return false
  )

  $(window).scroll(() ->
    if(window.currentTask == 'search' && loadTimes >= 1 && isLastLoadFinished && !window.isAllLoaded)
      if($(window).scrollTop() + $(window).height() > $(document).height() - 50)
        loadProducts(loadTimes*batchLoadNum)
    $('#mask').css({top:$(window).scrollTop()})
  )

  $('#product-list').masonry(
    itemSelector: '.product-cell'
  )

)

onProductClick = (e) ->
  window.currentTask = 'review'
  $('#product-list').hide()
  $('#loading-box').show()
  $('html, body').scrollTop(0)
  $.ajax(
    url: '/products/' + $(e.currentTarget).children('.product-id').html() + '.js'
    success: (data, textStatus, jqXHR)->
    error: (jqXHR, textStatus, errorThrown) ->
      console.log('Get aspects error. ' + textStatus)
  )

onSearchSubmit = (e) ->
  loadTimes = 0
  window.isAllLoaded = false
  window.currentTask = 'search'
  $('#product-list').empty().show()
  $('#product-show').hide()
  $('#loading-box').show()
  loadProducts(loadTimes*batchLoadNum)

  $('#top-container').animate(
    top: -($('input[name=keyword]').offset().top - $('#top-container').offset().top - 15) + 'px'
  ,800,'easeOutCubic')
  $('#big-title-box').animate(
    opacity: 0
  ,600)
  $('#mask').animate(
    opacity: 1
  ,1000)

loadProducts = (since) ->
  isLastLoadFinished = false
  window.searchKeyword = $('input[name=keyword]').val()
  $.ajax(
    url: '/products.js?keyword=' + window.searchKeyword + '&since=' + since
    success: (data, textStatus, jqXHR)->
      loadTimes = loadTimes + 1
      isLastLoadFinished = true
    error: (jqXHR, textStatus, errorThrown) ->
      isLastLoadFinished = true
      console.log('Get aspects error. ' + textStatus)
  )

showProductList = ->
  alert('ha')
  $('#product-list').animate(
    opacity: 1
  ,600)
