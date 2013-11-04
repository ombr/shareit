$ ()->
  preload=->
    $div = $('<div style="position: absolute; top: -9999px; left: -9999px"></div>')
    $('body').append($div)
    $('.preload').each (i, e)->
      setTimeout(()->
        $.get($(e).attr('href'), (data)->
          $div.append(data.split('<body>').pop().split('</body>')[0])
        )
      , 500 * i)

  blink_controls = ()->
    $('.control').each (e)->
      $e = $(this)
      $e.animate({opacity: 0.8}, 100, ()->
        setTimeout ()->
          $e.animate(opacity: 0, 1000)
        ,1000
      )
  $( window ).load ->
    preload()
    $('.control').animate(opacity: 0, 1000)
    $(document).on 'page:load', ()->
      $('.control').animate(opacity: 0, 1000)
      preload()



    $(document).on 'click', '.content', ->
      blink_controls()
  $(window).on 'orientationchange', ()->
    blink_controls()




  #
  # Full screen API :
  #
  #$(document).on 'click', '.fullscreen', (e)->
    #e.preventDefault()
    #$e = $(e.target)
    #$.get $e.attr('href'), (data)->
      #$('body').html(data.split('<body>').pop().split('</body>')[0])
      #preload()

  #if BigScreen.enabled
    #$( "<style>.fullscreen_toggle { display: block; }</style>" ).appendTo( "head" )
    #$(document).on 'click', '.fullscreen_toggle', (e)->
      #BigScreen.toggle(document.body)
