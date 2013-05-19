require 'spec_helper'
# require 'lib/wiki_import'

# describe 'The Article parser' do 

# 	before do
# 		@article = Article.make
# 		dummy_text = "<page><title>#{@article.title}</title><text>#{@articles.body}</text></page>"

# 		document = WikiImport.new(Rails.logger)
# 		parser = Nokogiri::XML::SAX::Parser.new(document
		

# 		@document = double("WikiImport")
# 		@document.should_receive(:start_document).once
# 		@document.should_receive(:start_element_namespace)
# 		@document.should_receive(:characters)
# 		@document.should_receive(:end_element_namespace)
# 		@document.should_receive(:end_document).once

# 		@parser.parse(dummy_text)
# 	end

# 	it "creates an Article in the database" do
# 		Article.count.should eq(1)
# 	end

# end

describe "the Action mailer" do
	before do
		ThinkingSphinx::Test.init
		ThinkingSphinx::Test.start_with_autostop

		@articles = 3.times {
			article = Article.make

			article.save!

		}
		@article = Article.random_article



	end

	it "should grab a random article" do
		@article.should be 
	end

	it "should have a title and body" do
		@article.title.should be
		@article.body.should be
	end

end

