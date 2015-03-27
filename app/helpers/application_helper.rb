module ApplicationHelper

  def icon(name)
    "<span class=\"glyphicon glyphicon-#{name}\"><span>".html_safe
  end

end
