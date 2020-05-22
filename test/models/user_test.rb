require "test_helper"

describe User do
  describe "validation" do
    it "is valid when the username is provided" do
      # Arrange
      @user = User.create(username: "loren", joined: Date.today)
      # Act
      result = @user.valid?
      # Assert
      expect(result).must_equal true
    end

    it "is invalid when the username is not provided" do 
      # Arrange
      @user = User.create(username: nil,
      joined: Date.today)
      # Act
      result = @user.valid?
      # Assert
      expect(result).must_equal false
      expect(@user.errors.messages).must_include :username
    end

    it "is invalid when user is not unique(case insensitive). ie: aaa == AAA" do
      # Arrange
      @user = User.create(username: "loren",
      joined: Date.today)
      @user2 = User.create(username: "LOREN",
      joined: Date.today)
      # Act
      result = @user2.valid?
      # Assert
      expect(result).must_equal false
      expect(@user2.errors.messages).must_include :username
    end
  end

  describe "has_many relationship" do
    before do
      # Arrange
      @work = Work.create!(title: "test work", category: "album", creator: "test creator", year: 1990, description: "This is the description for the test work")
      @user = User.create!(username: "loren",
        joined: Date.today)
      @vote = Vote.create!(work_id: @work.id, user_id: @user.id)
    end

    it "user has many votes" do 
      expect(@user.votes).must_include @vote
    end

    it "user has many works" do
      expect(@user.works).must_include @work
    end
  end
end
