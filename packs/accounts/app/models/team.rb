# == Schema Information
#
# Table name: teams
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Team < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships

  encrypts :name

  validates :name, presence: true, length: { minimum: 2, maximum: 200 }

  scope :personal, -> { joins(:memberships).where(memberships: { personal: true }).distinct }
  scope :editable, -> { personal.invert_where }

  before_destroy :prevent_destroying_personal_team, prepend: true

  encrypts :name

  private

  def prevent_destroying_personal_team
    if memberships.exists?(personal: true)
      errors.add(:base, :undestroyable)
      throw :abort
    end
  end
end
