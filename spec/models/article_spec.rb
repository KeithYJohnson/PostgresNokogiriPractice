require 'spec_helper'
require 'lib/wiki_import'

describe 'The Article parser' do 

	before do
		@article = Article.make
		dummy_text = "<page><title>#{@article.title}</title><text>#{@articles.body}</text></page>"

		document = WikiImport.new(Rails.logger)
		parser = Nokogiri::XML::SAX::Parser.new(document
		

		@document = double("WikiImport")
		@document.should_receive(:start_document).once
		@document.should_receive(:start_element_namespace)
		@document.should_receive(:characters)
		@document.should_receive(:end_element_namespace)
		@document.should_receive(:end_document).once

		@parser.parse(dummy_text)
	end

	it "creates an Article in the database" do
		Article.count.should eq(1)
	end

end
