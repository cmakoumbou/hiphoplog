class ArtistsController < ApplicationController
  def index
  	@artists = Artist.all.order('name ASC').page(params[:page])
  end

  def show
  	@artist = Artist.find(params[:id])
  	@videos = @artist.videos.order('published_at DESC').page(params[:page])
  end
end