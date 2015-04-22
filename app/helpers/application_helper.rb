module ApplicationHelper

  def icon(name)
    "<span class=\"glyphicon glyphicon-#{name}\"><span>".html_safe
  end

  def event_status_options
    # [ ["發布","published"], ["草稿", "draft"] ]

    Event::STATUS.map{ |s| [ t(s, :scope => "event"), s] }
    #Event::STATUS.map{ |s| [ t( "event.#{s}" ), s] }
  end

end
