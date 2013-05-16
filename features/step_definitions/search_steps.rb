Given(/^a fascinating article about "(.*?)"$/) do |title|
	Article.make!(:title => title)
end

Given(/^assuming the Sphinx index is up to date$/) do
	ThinkingSphinx::Test.start_with_autostop
end

Given(/^I am on the homepage$/) do
	visit root_path
end

When(/^I search for "(.*?)"$/) do |term|
	fill_in "search_box", :with => term
	click_button "Search"
end

Then(/^I should see an article about "(.*?)"$/) do |title|
	assert page.has_content?(title)
end

