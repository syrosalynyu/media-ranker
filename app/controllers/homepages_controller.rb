class HomepagesController < ApplicationController
  def index
    # @works = Work.all
    # @albums = Work.where(category: "album")
    # @books = Work.where(category: "book")
    # @movies = Work.where(category: "movie")

    # Jordan suggested I can merge these into a hash. This can DRYed up my code in views.
    @works = { 
      albums: Work.work_by_votes('album', 10), 
      books: Work.work_by_votes('book', 10), 
      movies: Work.work_by_votes('movie', 10),
    }
    @spotlight = Work.highest_vote
  end
end
