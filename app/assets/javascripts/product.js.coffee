# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(->
  $('#search-form').bind('ajax:success', (evt, data, status, xhr)->
    console.log(data);
    for p in data
      $('product-list').append('
        <p>
          p.title
        </p>
        <p>
          p.price
        </p>
      ')
  );
);