# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  has_secure_password

  has_many :memberships, dependent: :destroy
  has_many :sessions, dependent: :destroy
  has_many :teams, through: :memberships

  normalizes :email, with: ->(e) { e.strip.downcase }
  encrypts :email, deterministic: true, downcase: true

  after_create :create_personal_team

  private

  def create_personal_team
    team = Team.create!(name: "Personal")
    memberships.create!(team:, personal: true)
  end
end
