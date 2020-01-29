class Team < ApplicationRecord
  has_many :memberships
  before_validation :set_uuid, on: :create
  validates :id, presence: true
  default_scope { order(:name) }

  def set_uuid
    self.id = SecureRandom.uuid
  end

  def self.active
    Team.where(active: true)
  end

  def members
    membership_ids = MemberTeam.where(teams_id: id, active: true)
  end

  def add_member(member_id)
    lead_id = lead_id.to_i
    return self if members.map(&:id).include?(member_id)

    MemberTeam.create(member_id: member_id, teams_id: id, active: true)
    self
  end

  def remove_member(member_id)
    member_id = member_id.to_i
    return self unless members.map(&:id).include?(member_id)

    MemberTeam.find_by(member_id: member_id, teams_id: id, active: true).update(active: false)
    self
  end

  after_initialize do
    self.active ||= true if new_record?
  end
end
