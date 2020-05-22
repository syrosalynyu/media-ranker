class WorksController < ApplicationController
  def index
    @works = { 
      albums: Work.work_by_votes('album', 10), 
      books: Work.work_by_votes('book', 10), 
      movies: Work.work_by_votes('movie', 10),
    }
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params)
    if @work.save
      redirect_to work_path(@work.id)
      return
    else
      render :new
      return
    end
  end

  def show
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def edit
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    elsif @work.update(work_params)
      redirect_to work_path(@work.id)
      return
    else
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])

    if @work.nil?
      head :not_found
      return
    else
      @work.destroy
      redirect_to works_path
      return
    end
  end

  def upvote
    @work = Work.find_by(id: params[:id])
    if session[:user_id]
      # the user had voted to this work before
      if @work.users.find_by(id: session[:user_id])
        flash[:error] = "Sorry, you've voted before."
      # the user never votes to this work  
      else 
        @user = User.find_by(id: session[:user_id])
        @vote = @user.votes.create(work_id: @work.id)
        flash[:notice] = "Thanks for voting."
      end
    else
      flash[:error] = "You must log in in order to vote."
    end
    # Redirects the browser to the page that issued the request, which is the current page.
    redirect_back fallback_location: works_path
  end

  private

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :year, :description)
  end 
end
