module ApplicationHelper
  def js_partial(name, options = {})
    options[:partial] = name
    escape_javascript(render(options)).gsub(' ', '').html_safe
  end

  def month_name(month)
    I18n.t('date.abbr_month_names')[month]
  end
end
