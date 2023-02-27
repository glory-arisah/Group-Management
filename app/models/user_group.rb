class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  enum :role, { user: 0, admin: 1 }
  validates :group_id, :user_id, presence: true
end
