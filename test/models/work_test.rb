require "test_helper"

describe Work do
  describe "validations" do
    it "is valid when all fields are present" do
      #Arrange
      @work = works(:bluebreaker)
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal true
    end

    it "is invalid when category isn't album, book, or movie" do
      # Arrange
      @work = works(:bluebreaker)
      @work.category = "TV show"
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it "is invalid when title is missing" do
      #Arrange
      @work = works(:bluebreaker)
      @work.title = nil
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title 
    end

    it "is invalid when title is not unique" do
      # Arrange
      @work2 = Work.create(title: "Blue Breaker", category: "album")
      # Act
      result = @work2.valid?
      # Assert
      expect(result).must_equal false
      expect(@work2.errors.messages).must_include :title
    end

    it "each category can have the same name once" do
      # Arrange
      @work2 = Work.create(title: "Blue Breaker", category: "book")
      # Act
      result = @work2.valid?
      # Assert
      expect(result).must_equal true
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

    it "work has many votes" do 
      expect(@work.votes).must_include @vote
    end

    it "work has many users" do
      expect(@work.users).must_include @user
    end
  end

  describe "custom method: highest_vote" do
    it "return the highest-voted work in the fixtures(title: Blue Breaker, has 2 votes)" do
      @works = Work.highest_vote
      expect(@works[0]).must_be_instance_of Work
      expect(@works[0].title).must_equal "Blue Breaker"
      expect(@works[1]).must_equal 2
    end
  end

  describe "custom method: work_by_votes" do
    it "return the top-ten ablums in the fixtures (there are 11 totel)" do
      @works = Work.work_by_votes("album", limit = 10)
      expect(@works.length).must_equal 10
      expect(@works[0].votes.count).must_equal 2
      expect(@works[1].votes.count).must_equal 1
      expect(@works[9].votes.count).must_equal 0
    end

    it "return all the existing works of that category if there are less than 10." do
      @works = Work.work_by_votes("book", limit = 10)
      expect(@works.length).must_equal 1
      expect(@works[0].title).must_equal "Joe Treat"
      # expect(@works[1]).must_equal 2
    end
  end
end
