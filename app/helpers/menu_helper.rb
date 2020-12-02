# typed: true
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

  def refresh_button_to(name, url)
    icon = tag.i class: 'fas fa-sync fa-sm mr-1'
    button_to url, form_class: 'form-inline ml-1', class: 'btn btn-outline-secondary btn-sm' do
      safe_join [icon, name]
    end
  end

  def navbar_brand
    if ENV['LOGO_URL']
      image_tag ENV['LOGO_URL'], alt: 'mdma', width: 30, height: 30, style: 'border-radius: 5px'
    else
      'mdma'
    end
  end
end
