class SongsController < ApplicationController
  def index
  	@songs = Song.order(published_at: :desc, created_at: :desc).page(params[:page]).per(3)
  end
end
