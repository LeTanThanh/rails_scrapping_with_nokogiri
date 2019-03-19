class MoviesController < ApplicationController
  def index
    @now_showing_movies = Movie.now_showing
    @coming_soon_movies = Movie.coming_soon
  end
end
