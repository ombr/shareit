$('.pagination').replaceWith('<%= j will_paginate(@posts) %>')

<% if @direction == 'up' %>
reference = $('#posts').children().first()
before =  reference.offset().top
$('#posts').prepend('<%= j render(@posts) %>')
after =  reference.offset().top
$('body').scrollTop($('body').scrollTop() - (before - after))
<% else %>
$('#posts').append('<%= j render(@posts) %>')
<% end %>
