# Methods related to the navigation menu
module MenuHelper
  def nav_link_to(name, url, icon:)
    active = current_page?(url)
    li_class = active ? 'nav-item active' : 'nav-item'
    fa_icon = tag.i nil, class: "fas fa-#{icon} ml-1"
    indicator = tag.span '(current)', class: 'sr-only' if active
    tag.li class: li_class do
      link_to url, class: 'nav-link' do
        safe_join [fa_icon, name, indicator].compact, ' '
      end
    end
  end
end
