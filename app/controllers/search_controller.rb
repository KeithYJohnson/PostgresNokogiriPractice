class SearchController < ApplicationController
	def search
		@results = Article.search(params[:search])
		
	end
end
