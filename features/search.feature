Feature: A music fan search for articles

	As a music fan
	I want to read bigrpahical information about an artist

	Scenario:  A music fan searches fora n Article by title
		Given a fascinating article about "searching with Sphinx"
			#This step will create a sphinx index
			# we would never do this in development or production 
		And assuming the Sphinx index is up to date
		And I am on the homepage
		When I search for "Sphinx"
		Then I should see an article about "searching with Sphinx" 