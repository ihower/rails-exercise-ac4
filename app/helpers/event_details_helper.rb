module EventDetailsHelper

  def build_event(x)
    x.build_detail unless x.detail

    return x
  end

end
