class VideosController < ApplicationController
  def index
  	@videos = Video.order(published_at: :desc, created_at: :desc).page(params[:page]).per(3)
  end
end
