class ArtistsController < ApplicationController
  def index
  	@artists = Artist.order(name: :asc).page(params[:page]).per(3)
  end

  def show
  	@artist = Artist.find(params[:id])
  	@videos = @artist.videos.order(published_at: :desc, created_at: :desc)
  	@songs = @artist.songs.order(published_at: :desc, created_at: :desc)
    @albums = @artist.albums.order(published_at: :desc, created_at: :desc)

  	@releases = @videos + @songs + @albums
  	@releases = @releases.sort_by(&:published_at).reverse
  	@releases = Kaminari.paginate_array(@releases).page(params[:page]).per(3)
  end
end