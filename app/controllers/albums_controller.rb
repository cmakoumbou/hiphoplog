class AlbumsController < ApplicationController
  def index
  	@albums = Album.order(published_at: :desc, created_at: :desc).page(params[:page]).per(3)
  end
end