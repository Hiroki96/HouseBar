module ApplicationHelper
  def created_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end

  def created_time_to_health(time)
    time.strftime("%Y-%m-%d")
  end

end
