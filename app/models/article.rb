class Article < ActiveRecord::Base
  attr_accessible :title, :body

 	
  def self.random_article
  	max = Article.maximum(:id)
  	min = Article.first.id
  	randomarticle = nil

  	while !randomarticle 
  		rand = rand(min...max)
  		randomarticle = Article.find(rand)
  	end
  	return randomarticle
  end
end
