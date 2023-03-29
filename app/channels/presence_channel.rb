class PresenceChannel < ApplicationCable::Channel
  def self.user_still_connected?(user)
    still_there = broadcast_to(user, action: 'presence-check')
    still_there.present? && still_there.positive?
  end

  def subscribed
    stream_from "PresenceChannel"
    stream_for current_user
  end
end
