class OnlineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "OnlineChannel"

    OnlineService.new(user: current_user, is_online: true).perform
  end

  def unsubscribed
    return if ActionCable.server.connections.count { |connection| connection.current_user == current_user } > 0

    OnlineService.new(user: current_user, is_online: false).perform
  end
end
