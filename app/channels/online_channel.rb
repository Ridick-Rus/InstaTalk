class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "OnlineChannel"
    current_user.update(is_online: true);

    ActionCable.server.broadcast("OnlineChannel", { user: current_user })
  end

  def unsubscribed
    current_user.update(is_online: false);

    ActionCable.server.broadcast("OnlineChannel", { user: current_user })
  end
end
