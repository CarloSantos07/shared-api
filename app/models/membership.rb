class Membership < ApplicationRecord
  belongs_to :team, optional: true
  before_validation :set_uuid, on: :create
  validates :id, presence: true
  default_scope { order(:name) }

  def set_uuid
    self.id = SecureRandom.uuid
  end

  def self.active
    Member.where.not(memberships_id: nil).to_a
  end

  def teams
    team_ids = MembershipTeam.where(member_id: google_user_id, active: true).map(&:teams_id).uniq
    Team.find(team_ids)
  end
end
