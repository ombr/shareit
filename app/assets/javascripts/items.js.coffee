preload=->
  $('.preload').each (i, e)->
    $div = $('<div style="position: absolute; top: -9999px; left: -9999px"></div>')
    $('body').append($div)
    setTimeout(()->
      $.get($(e).attr('href'), (data)->
        $div.append(data.split('<body>').pop().split('</body>')[0])
      )
    , 500 * i)

$( window ).load ->
  preload()
  $(document).on 'page:load', ()->
    preload()
