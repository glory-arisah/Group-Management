class GroupsController < ApplicationController
  include GroupsHelper
  before_action :find_group,
                only: %i[show manage view_members add_user edit update destroy]

  def index
    @groups = current_user.groups.all
    @owned_groups = @groups.select { |group| user_role(group, current_user) == 'admin' }
    @other_groups = @groups.reject { |group| @owned_groups.include? group }
  end

  def show
  end

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.create(group_params)
    @user_group =
      UserGroup.find_by(group_id: @group.id, user_id: current_user.id)
    @user_group.update(role: "admin")
    p @user_group.inspect

    if @group
      redirect_to @group
    else
      render :new
    end
  end

  def edit
  end

  def manage
    @group_users = @group.users
    @other_users = User.all.reject { |user| @group_users.include? user }
    @user_group = @group.user_groups.new
  end

  def view_members
    @group_users = @group.users
  end

  def update
    if @group.update(group_params)
      @group.reload
      redirect_to "/groups/#{@group.id}"
    else
      render :manage
    end
  end

  def destroy
    @group = current_user.groups.find_by(id: params[:id])
    @group.destroy

    redirect_to "/"
  end

  private

  def find_group
    @group = current_user.groups.find_by(id: params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description)
  end
end
