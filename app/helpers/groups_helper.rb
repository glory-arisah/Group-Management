module GroupsHelper
  def user_role(group, user)
    user_group = UserGroup.find_by(group_id: group.id, user_id: user.id)
    user_group.role
  end
end
