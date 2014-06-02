# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

batchLoadNum = 15
loadTimes = 0
isLastLoadFinished = true
window.isAllLoaded = false
window.searchKeyword = ''

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

  $('input[name=authenticity_token]').attr('value', $('meta[name=csrf-token]').attr('content'))
  $('#search-box input[name=submit]').click(onSearchSubmit)
  $(window).keydown((event) ->
      if(event.keyCode == 13)
        $('#search-box input[name=submit]').trigger('click')
        event.preventDefault()
        return false
  )

  $(window).scroll(() ->
    if(loadTimes >= 1 && isLastLoadFinished && !window.isAllLoaded)
      if($(window).scrollTop() + $(window).height() > $(document).height() - 50)
        loadProducts(loadTimes*batchLoadNum)
        console.log('load ' + loadTimes)
  )

  $('#product-list').masonry(
    itemSelector: '.product-cell'
  )

)

onProductClick = (e) ->
  $.ajax(
    url: '/products/' + $(e.currentTarget).children('.product-id').html() + '.js'
    success: (data, textStatus, jqXHR)->
    error: (jqXHR, textStatus, errorThrown) ->
      console.log('Get aspects error. ' + textStatus)
  )

onSearchSubmit = (e) ->
  loadTimes = 0
  window.isAllLoaded = false
  $('#product-list').empty()
  loadProducts(loadTimes*batchLoadNum)

  $('#top-container').animate(
    top: "-40px"
  ,1000,'easeOutCubic')
  $('#big-title-box').animate(
    opacity: 0
  ,600)
  $('body').animate(
    backgroundColor: "#EEEEEE"
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
