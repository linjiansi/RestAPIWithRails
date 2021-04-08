require 'rails_helper'

RSpec.describe Book, type: :model do
  describe "relation" do
    it { should belong_to(:user) }
  end
end
