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
        paginate_url()

  $('#posts').waypoint
    handler: (direction)->
      load 'up', next_url, ()->
        next_url = get_url('up')
        paginate_url()

paginate_url=()->
  $('#posts>div').waypoint('destroy')
  $('#posts>div').waypoint
    handler: ()->
      page = $(this).data('page')
      return if window.history.state.page? and window.history.state.page == page
      window.history.pushState({page: page}, '', page)
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
