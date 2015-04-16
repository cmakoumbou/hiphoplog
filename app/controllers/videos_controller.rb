class VideosController < ApplicationController
  def index
  	@videos = Video.all.order('published_at DESC').page(params[:page]).per(4)
  end
end
