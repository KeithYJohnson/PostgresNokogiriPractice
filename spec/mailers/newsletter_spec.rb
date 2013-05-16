require "spec_helper"

describe Newsletter do

	describe "A exciting newsletter mailout" do
		before do
			#Create uesers who are registered and confirmed
			@members = 3.times {
				user = User.make
				user.skip_confirmation!
				user.save!

			}
			@members = User.all.map {|u| u.email}

			#Create a user who isn't registered
			User.make!
			@email = Newsletter.mailout.deliver
		end

		it "should send to a SMTP server" do
			#This is like a queue of outgoing emails.
			ActionMailer::Base.deliveries.length.should be
		end

		it "should have a subject" do
			@email.subject.should eq("More Amazing News from your friends at")
		end
 
		it "should be sent to all our Users in the BCC field" do
			@email.bcc.should eq(@members)
		end

		it "should not put anyone in the to address" do
			@email.to.should be_empty 
		end

		it "should greet out members with a warm salutation" do
			@email.encoded.should match /Hello there dear customer/ 
		end 
	end 
end
