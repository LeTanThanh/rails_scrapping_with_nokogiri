class MoviesController < ApplicationController
  def index
    @now_showing_movies = Movie.now_showing
    @coming_soon_movies = Movie.coming_soon
  end

  def show
    @movie = Movie.find_by id: params[:id]
    @random_movie_ids = Movie.where.not(id: params[:id]).pluck(:id).sample(10)
    @random_movies = Movie.where(id: @random_movie_ids)
  end
end
