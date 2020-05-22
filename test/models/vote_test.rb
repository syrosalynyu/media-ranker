require "test_helper"

describe Vote do
  describe "belongs_to relationship" do
    before do
      # Arrange
      @work = Work.create!(title: "test work", category: "album", creator: "test creator", year: 1990, description: "This is the description for the test work")
      @user = User.create!(username: "loren",
        joined: Date.today)
      @vote = Vote.create!(work_id: @work.id, user_id: @user.id)
    end

    it "vote belongs to work" do 
      expect(@vote.work).must_equal @work
    end

    it "vote belongs to user" do
      expect(@vote.user).must_equal @user
    end
  end
end