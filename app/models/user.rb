class User < ApplicationRecord
  has_many :messages, dependent: :destroy

  before_create :generate_nickname

  def generate_nickname
    self.nickname = "#{Faker::Name.first_name.downcase}_#{Faker::Name.last_name.downcase}"
  end
end
