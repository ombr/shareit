$("#post-<%=@post.id%>").replaceWith("<%= escape_javascript render 'show'%>")
