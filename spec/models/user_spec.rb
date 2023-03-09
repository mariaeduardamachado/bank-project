require 'rails_helper'

RSpec.describe User, type: :model do 
  describe "User validate" do
    let(:user_without_name) {build(:user, name:nil)}
    let(:user) {build(:user)}

    it "user is valid" do 
      expect(user).to be_valid
    end

    it "user is not valid" do 
      expect(user_without_name).to_not be_valid
    end
  end
end
