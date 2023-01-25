require "rails_helper"

RSpec.describe UserGroup, type: :model do
  describe "validations:" do
    it { should validate_presence_of(:group_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:role) }
  end

  describe "associations:" do
    let!(:group1) { create(:group) }
    let!(:group2) { create(:group, name: "new group", description: "new group desc") }
    let!(:user1) { create(:user) }
    let!(:user_group1) { create(:user_group, group: group1, user: user1) }
    let!(:user_group2) { create(:user_group, group: group2, user: user1, role: 0) }

    it { should belong_to(:group) }
    it { should belong_to(:user) }

    context "data persists:" do
      it "should get group and user associated with user_group" do
        expect(user_group1.group).to eq group1
        expect(user_group1.user).to eq user1
        expect(user_group2.group).to eq group2
      end

      it "should exist as a child to group and user" do
        expect(user1.user_groups.count).to eq(2)
        expect(group1.user_groups.count).to eq(1)
        # expect(user_group1.role).to eq("admin")
        # expect(user_group2.role).to eq("user")
      end
    end
  end
end
