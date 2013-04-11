class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
	
	@all_ratings = Movie.ratings	

	
	if params[:ratings].nil? then
		session[:ratings] ||= @all_ratings
	else
		session[:ratings] = params[:ratings].keys
	end
	
	
	session[:sort_by] = params[:sort_by] unless params[:sort_by].nil?
	@sort_filter = session[:sort_by]

	@rating_filter = session[:ratings]
	@movies = Movie.order(@sort_filter).where(:rating => @rating_filter)

	@all_ratings.each do |k,v|
		@all_ratings[k] = false unless @rating_filter.include?(k)
	end

	@preserved_ratings = Hash.new()

	@rating_filter.each do |k|
		@preserved_ratings[k] = 1
	end
	

	
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
