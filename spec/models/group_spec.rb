require 'rails_helper'

RSpec.describe Group, type: :model do
  describe "validations:" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
  end

  describe "associations:" do
    it { should have_many(:user_groups) }
    it { should have_many(:users).through(:user_groups) }
  end

  describe "data persists:" do
    it "name and descriptio should be persisted" do
      group = build(:group)

      expect(group.name).to eq("group1")
      expect(group.description).to eq("group1 description")
    end
  end
end
