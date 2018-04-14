module Admin::BaseHelper
  def sidebar_activate(sidebar_link_url)
    current_url = request.headers['PATH_INFO']
    current_url.match(sidebar_link_url) ? ' class="active"' : ''
  end

  def sidebar_list_items
    items = [
      {text: 'USERS', path: admin_users_path},
      {text: 'GROUP', path: '#'}
    ]
    html = ''
    items.each do |item|
      text = item[:text]
      path = item[:path]
      html = html + %Q(<li#{sidebar_activate(path)}><a href="#{path}">#{text}</a></li>)
    end

    raw(html)
  end
end
