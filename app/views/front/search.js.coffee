$('dl').append("<%= js_partial @documents %>")

$('#load-more-docs')
  <% if params[:page].to_i < @documents.total_pages %>
  .attr('href', '/search?page=<%=params[:page].to_i+1%>&q=<%=params[:q]%>')
  .removeClass('btn-disabled')
  .removeAttr('disabled')
  .html('Ver mais')
  <% else %>
  .remove()
  <% end %>
