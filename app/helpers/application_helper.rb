# encoding: UTF-8

module ApplicationHelper

  def js_partial(name, options = {})
    options[:partial] = name
    escape_javascript(render(options)).gsub(" ", '').html_safe
  end

  def month_name(month)
    %w{Janeiro Fevereiro Março Abril Maio Junho Julho Agosto Setembro Outubro Novembro Dezembro}[month]
  end

end
