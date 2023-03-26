class UserGroupsController < ApplicationController
  before_action :find_group

  def create
    @user_group = @group.user_groups.create(user_group_params)
    redirect_to "/groups/#{@group.id}/manage"
  end

  def destroy
    @user_group = UserGroup.find_by(id: params[:id])
    @user_group.destroy
    redirect_to '/'
  end

  private

  def find_group
    @group = Group.find_by(id: params[:group_id])
  end

  def user_group_params
    params.require(:user_group).permit(:group_id, :user_id, :role)
  end
end
