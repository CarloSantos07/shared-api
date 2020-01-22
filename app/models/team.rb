class Team < ApplicationRecord
  has_many :memberships

  before_validation :set_uuid, on: :create
  validates :id, presence: true

  def set_uuid
    self.id = SecureRandom.uuid
  end
end
