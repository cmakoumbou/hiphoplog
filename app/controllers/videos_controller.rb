class VideosController < ApplicationController
  def index
  	@videos = Video.order('published_at DESC').page(params[:page]).per(15)
  	respond_to do |format|
  		format.html
  		format.js
		end
  end
end
