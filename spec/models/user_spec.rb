require "rails_helper"

RSpec.describe User, type: :model do
  describe "validations:" do
    # subject { create(:user) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:email) }
    # it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe "associations:" do
    let!(:group1) { create(:group) }
    let!(:group2) { create(:group, name: "new group", description: "new group desc.") }
    let!(:user) { create(:user, email: 'earisah@gmail.com') }
    let!(:user_group1) { create(:user_group, group: group1, user: user) }
    let!(:user_group2) { create(:user_group, group: group2, user: user, role: 0) }

    it { should have_many(:user_groups) }
    it { should have_many(:groups).through(:user_groups) }

    describe "data persists:" do
      it "username, full_name and email should be persisted" do
        expect(user.username).to eq("garisah")
        expect(user.full_name).to eq("Glory Arisah")
        expect(user.email).to eq("earisah@gmail.com")
      end

      it "has many user_groups" do
        expect(user.user_groups.count).to eq(2)
      end

      it "has many groups" do
        expect(user.groups.count).to eq(2)
        expect(user.groups.first.name).to eq("group1")
        expect(user.groups.last.name).to eq("new group")
      end
    end
  end

end
