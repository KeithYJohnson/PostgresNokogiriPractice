class SearchController < ApplicationController
	def search
		@pagenumber = params[:page] || 0
    	@results_size = 30

		@results = Article.search(params[:search], :limit=>@results_size, :offset=>(@pagenumber.to_i*@results_size))
	end
end
