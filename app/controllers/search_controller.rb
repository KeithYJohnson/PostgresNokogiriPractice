class SearchController < ApplicationController
	def search
		@results = Article.search(params[:term])
	end
end
