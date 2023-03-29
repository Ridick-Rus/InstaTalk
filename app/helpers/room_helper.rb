module RoomHelper
  def room_html(room)
    "- <span class=\"room\">room ##{room}</span> -".html_safe
  end
end
