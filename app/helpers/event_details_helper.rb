module EventDetailsHelper

  def merge_event_filters(params, option)
    filters = params.slice(:order, :category_id)
    filters.merge(option)
  end

  def build_event(x)
    x.build_detail unless x.detail

    return x
  end

end
