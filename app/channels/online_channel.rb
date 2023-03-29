class OnlineChannel < ApplicationCable::Channel
  after_unsubscribe :handle_offline

  def subscribed
    stream_from "OnlineChannel"

    OnlineService.new(user: current_user, is_online: true).perform
  end

  private

  def handle_offline
    HandleOfflineJob.set(wait: 5.seconds).perform_later(current_user)
  end
end
