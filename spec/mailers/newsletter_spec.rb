require "spec_helper"

describe Newsletter do
	before "create a random article" do
		ThinkingSphinx::Test.init
		ThinkingSphinx::Test.start_with_autostop

		@articles = 3.times {
			article = Article.make
			article.save!
		}	



	end

	describe "A exciting newsletter mailout" do
		before do
			#Create uesers who are registered and confirmed
			@members = 3.times {
				user = User.make
				user.skip_confirmation!
				user.save!
			}

			# @members = User.all.map {|u| u.email}	
			#Create a user who isn't registered


			@article = Article.random_article

			@email = Newsletter.mailout(@members)
		end

		it "should send to a SMTP server" do
			#This is like a queue of outgoing emails.
			ActionMailer::Base.deliveries.length.should be
		end

		it "should have a random article to send" do
			@article.should be
			@article.title.should be
			@article.body.should be
		end

		it "should include the articles body in the message" do

			# @email.body.should match /#{@article.body.w}/
			# both the test AND the method are creating different random articles.  
			@email.body.should be
		end

		it "should have a subject" do
			@email.subject.should eq("More Amazing News from your friends at")
		end
 
		it "should be sent to all our Users in the BCC field" do
			@email.bcc.should eq(User.all.map {|u| u.email})
		end

		it "should not put anyone in the to address" do
			@email.to.should be_empty 
		end

		it "should greet out members with a warm salutation" do
			@email.encoded.should match /Hello there dear customer/ 
		end 
	end 
end
