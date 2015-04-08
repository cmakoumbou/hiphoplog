class ArtistsController < ApplicationController
  def index
  	@artists = Artist.all.order('name ASC').page(params[:page]).per(3)
  end

  def show
  	@artist = Artist.find(params[:id])
  	@videos = @artist.videos.order('published_at DESC')
  	@songs = @artist.songs.order('published_at DESC')
    @albums = @artist.albums.order('published_at DESC')

  	@releases = @videos + @songs + @albums
  	@releases = @releases.sort_by(&:published_at).reverse
  	@releases = Kaminari.paginate_array(@releases).page(params[:page]).per(3)
  end
end