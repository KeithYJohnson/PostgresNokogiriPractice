class Newsletter < ActionMailer::Base
  default from: "wdi.devtest@gmail.com"

  def self.mail_confirmed
  	members = User.select(:email).confirmed.all
  	binding.pry

  	members.each do |user|
  		mailout user
  	end
  end

  def mailout(user)
  	@article = Article.random_article
  	members = User.confirmed.all.map {|u| u.email}
  	mail :to => [], :bcc => members, :subject => "More Amazing News from your friends at"
  end
  
end
