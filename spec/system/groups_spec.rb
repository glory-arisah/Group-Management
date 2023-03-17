require "rails_helper"

RSpec.describe "Groups", type: :system do
  before { driven_by(:rack_test) }

  describe "logged in user:" do
    let!(:user1) { create(:user, email: "earisah@gmail.com") }
    let!(:user2) { create(:user, email: "farisah@gmail.com") }
    let!(:group1) do
      create(:group, name: "group 1", description: "group 1 desc")
    end
    let!(:group2) do
      create(:group, name: "group 2", description: "group 2 desc")
    end
    let!(:ug1) do
      create(:user_group, user: user1, group: group1, role: "admin")
    end
    let!(:ug2) do
      create(:user_group, user: user2, group: group2, role: "admin")
    end
    let!(:ug3) { create(:user_group, user: user1, group: group2, role: "user") }
    before { log_in_attempt user1.email, user1.password }

    scenario "can view groups" do
      expect(page).to have_content("View your groups")
      expect(page).to have_link("Create group")
      expect(page).to have_link("group 1")
    end

    scenario "can create groups" do
      visit "/groups/new"
      expect(page).to have_content("Make a group!")
      expect(page).to have_button("Let's go!")
      create_update_group
      click_on "Let's go!"

      # expect(page).to have_current_path("/groups/#{}")
      expect(page).to have_text("new group")
    end

    scenario "is the admin of his created group" do
      click_on "#{group1.name}"
      expect(page).to have_current_path("/groups/#{group1.id}")

      expect(ug1.user).to eq(user1)
      expect(ug1.role).to eq("admin")
      expect(page).to have_link("Manage Group")
    end

    describe "update group" do
      scenario "he/she created" do
        click_on "#{group1.name}"
        click_on "Manage Group"
        expect(page).to have_current_path("/groups/#{group1.id}/manage")
        # visit "/groups/#{group1.id}/manage"

        create_update_group
        click_on "Let's go!"

        group1.reload
        expect(group1.name).to eq("new group")
        expect(group1.description).to eq("new group description")
      end

      scenario "cannot update group he/she did not create" do
        visit "/groups/#{group2.id}"

        expect(page).to have_link("View Members")
      end
    end

    describe "delete group" do
      scenario "created by user only" do
        visit "/groups/#{group1.id}"
        click_on "Manage Group"

        expect(page).to have_current_path("/groups/#{group1.id}/manage")
        expect { click_on "Delete Group" }.to change { user1.groups.count }.by(-1)
      end

      scenario "cannot if user is not admin" do
        visit "/groups/#{group2.id}"
        expect(page).to have_link("View Members")
      end
    end

    scenario "admin can add/remove members to a group" do
      visit "/groups/#{group1.id}/manage"
      # add user to group
      click_on 'Add User'
      expect(page).to have_link("Remove User")

      # remove user from group
      find(".remove-user", match: :first).click
      expect(page).to have_button("Add User")
    end

    scenario "can only view members if he is not admin" do
      click_on "#{group2.name}"
      click_on "View Members"

      expect(page).to have_current_path("/groups/#{group2.id}/view_members")
      expect(page).to have_text("#{user2.username} - Admin")
      expect(page).to have_text("#{user1.username}")
    end

    def create_update_group
      fill_in "Name", with: "new group"
      fill_in "Description", with: "new group description"
    end

    def user_role(group, user)
      user_group = UserGroup.find_by(group_id: group.id, user_id: user.id)
      user_group.role
    end
  end

  describe "non-logged in user:" do
    scenario "cannot view groups" do
      visit "/"

      expect(page).to have_content("Welcome to GM")
      expect(page).to have_link("Sign up")
      expect(page).to have_link("Log in")
    end

    scenario "cannot create groups" do
      visit "/groups/new"

      expect(page).to have_content(
        "You need to sign in or sign up before continuing."
      )
    end
  end
end
