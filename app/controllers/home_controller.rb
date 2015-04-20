class HomeController < ApplicationController
	def index
  	@videos = Video.all.order('published_at DESC')
  	@songs = Song.all.order('published_at DESC')
  	@albums = Album.all.order('published_at DESC')

  	@releases = @videos + @songs + @albums
  	@releases = @releases.sort_by(&:published_at).reverse
  	@releases = Kaminari.paginate_array(@releases).page(params[:page]).per(27)
  end
end
