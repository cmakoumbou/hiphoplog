class VideosController < ApplicationController
  def index
  	@videos = Video.all.order('published_at DESC').page(params[:page]).per(3)
  	respond_to do |format|
  		format.html
  		format.js
		end
  end
end
