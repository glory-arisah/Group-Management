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
    # it "has many groups and user_groups" do
    #   user_group_relation = User.reflect_on_association(:user_groups)
    #   expect(user_group_relation.macro).to eq :has_many
    #   group_relation = User.reflect_on_association(:groups)
    #   expect(group_relation.macro).to eq :has_many
    # end
    it { should have_many(:user_groups) }
    it { should have_many(:groups).through(:user_groups) }
  end

  describe "data persists:" do
    it "username, full_name and email should be persisted" do
      user = build(:user)

      expect(user.username).to eq("garisah")
      expect(user.full_name).to eq("Glory Arisah")
      expect(user.email).to eq("garisah-1@gmail.com")
    end
  end
end
