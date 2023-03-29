class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "OnlineChannel"
    current_user.update(is_online: true);

    OnlineService.new(user: current_user).perform
  end

  def unsubscribed
    current_user.update(is_online: false);

    OnlineService.new(user: current_user).perform
  end
end
