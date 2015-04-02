class SearchController < ApplicationController
  def index
  	@search = PgSearch.multisearch(params[:query]).page(params[:page]).per(1)
  end
end
