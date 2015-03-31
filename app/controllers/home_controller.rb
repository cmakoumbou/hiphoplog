class HomeController < ApplicationController
  def index
  	@videos = Video.all.order('published_at DESC').page(params[:page])
  end

  def search
 		@results = PgSearch.multisearch(params[:query]).page(params[:page])
  end
end
