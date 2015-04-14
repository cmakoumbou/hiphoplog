class SearchController < ApplicationController
  def index
  	@search = PgSearch.multisearch(params[:query]).reorder('id ASC').page(params[:page]).per(3)
  end
end
