class SearchController < ApplicationController
  def index
  	@search = PgSearch.multisearch(params[:query]).page(params[:page]).per(3)
  end
end
