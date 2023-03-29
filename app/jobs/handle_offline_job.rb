class HandleOfflineJob < ApplicationJob
  queue_as :critical

  def perform(user)
    OnlineService.new(user: user, is_online: false).perform unless PresenceChannel.user_still_connected?(user)
  end
end
