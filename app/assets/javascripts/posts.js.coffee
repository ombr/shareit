get_url = (direction)->
  if direction == 'up'
    $(".pagination .previous_page").attr('href')
  else
    $(".pagination .next_page").attr('href')

load = (direction, url, callback)->
  if get_url(direction) and url
    $('.pagination').text("Fetching more products...")
    $.getScript "#{url}?direction=#{direction}", callback

paginate = ()->
  next_url = get_url('up')
  previous_url = get_url('down')
  $('#posts').waypoint
    offset: 'bottom-in-view'
    handler: (direction)->
      load 'down', previous_url, ()->
        $.waypoints('refresh');
        previous_url = get_url('down')

  $('#posts').waypoint
    handler: (direction)->
      load 'up', next_url, ()->
        next_url = get_url('up')

$(document).on 'page:load', ()->
  if $('.pagination').length
    paginate()
$( window ).load ->
  if $('.pagination').length
    paginate()


  #$(window).scroll ()->
    #window.history.pushState {}, '', $('[data-page]:visible').first().data('page')
    #if $(window).scrollTop() > $(document).height() - $(window).height() - 50
      #load 'down', previous_url, ()->
        #previous_url = get_url('down')
