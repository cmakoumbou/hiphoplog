class AlbumsController < ApplicationController
  def index
  	@albums = Album.all.order('published_at DESC').page(params[:page]).per(3)
  end
end
