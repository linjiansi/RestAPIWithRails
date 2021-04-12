require 'rails_helper'

RSpec.describe User,
               type: :model do
  describe "relation" do
    it { should have_many(:books) }
  end

  describe "validation" do
    context "email" do
      it { should validate_presence_of(:email) }
      it { should validate_length_of(:email).is_at_least(6) }
    end

    context "password" do
      it { should validate_presence_of(:password) }
      it { should validate_length_of(:password).is_at_least(6) }
    end
  end
end
