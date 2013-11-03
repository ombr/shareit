$ ()->
  go = (destination)->
    $(".#{destination}")[0].click()
  init = ()->
    Hammer(document.body,{
      swipe: true
      swipe_max_touches: 1
      swipe_velocity: 0.1
      }).on('swiperight',()->
        go 'previous'
      ).on('swipeleft',()->
        go 'next'
      )

  $( window ).load ->
    init()
    $(document).on 'page:load', ()->
      init()

  $(document).keydown (event)->
    switch event.which
      when 39, 32, 13, 9, 40
        go 'next'
      when 37, 8, 16, 38
        go 'previous'
      when 27
        go 'home'
      else
        console.log event.which
