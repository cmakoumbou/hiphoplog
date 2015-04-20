class HomeController < ApplicationController
	def index
  	@videos = Video.order(published_at: :desc, created_at: :desc)
  	@songs = Song.order(published_at: :desc, created_at: :desc)
  	@albums = Album.order(published_at: :desc, created_at: :desc)

  	@releases = @videos + @songs + @albums
  	@releases = @releases.sort_by(&:published_at).reverse
  	@releases = Kaminari.paginate_array(@releases).page(params[:page]).per(9)
  end
end
