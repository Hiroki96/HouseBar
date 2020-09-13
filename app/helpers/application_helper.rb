module ApplicationHelper
  def created_time(time)
    time.strftime("%Y-%m-%d %H:%M")
  end
end
