require "test_helper"

describe Work do
  describe "validations" do
    before do
      # Arrange
      @work = Work.create(title: "test work", category: "album", creator: "test creator", year: 1990, description: "This is the description for the test work")
    end

    it "is valid when all fields are present" do
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal true
    end

    it "is invalid when category isn't album, book, or movie" do
      # Arrange
      @work.category = "TV show"
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :category
    end

    it "is invalid when title is missing" do
      #Arrange
      @work.title = nil
      # Act
      result = @work.valid?
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title 
    end

    it "is invalid when title is not unique" do
      # Arrange
      @work2 = Work.create(title: "test work")
      # Act
      result = @work2.valid?
      # Assert
      expect(result).must_equal false
      expect(@work2.errors.messages).must_include :title
    end
  end


end
