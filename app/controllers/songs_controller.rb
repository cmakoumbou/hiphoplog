class SongsController < ApplicationController
  def index
  	@songs = Song.all.order('published_at DESC').page(params[:page]).per(4)
  end
end
