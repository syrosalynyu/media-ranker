class HomepagesController < ApplicationController
  def index
    @works = Work.all
    @albums = Work.where(category: "album")
    @books = Work.where(category: "book")
    @movies = Work.where(category: "movie")
  end
end
