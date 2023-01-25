require "rails_helper"

RSpec.describe Group, type: :model do
  describe "validations:" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe "associations:" do
    let!(:group) { create(:group) }
    let!(:user1) { create(:user, username: 'jarisah') }
    let!(:user2) { create(:user, username: 'karisah') }
    let!(:user_group1) { create(:user_group, group: group, user: user1) }
    let!(:user_group2) { create(:user_group, group: group, user: user2, role: 0) }

    it { should have_many(:user_groups) }
    it { should have_many(:users).through(:user_groups) }

    describe "data persists:" do
      it "name and description should be persisted" do
        expect(group.name).to eq("group1")
        expect(group.description).to eq("group1 description")
      end

      it "has many user_groups" do
        expect(group.user_groups.count).to eq(2)
      end

      it "has many users" do
        expect(group.users.count).to eq(2)
        expect(group.users.first.username).to eq('jarisah')
        expect(group.users.last.username).to eq('karisah')
      end
    end
  end
end
