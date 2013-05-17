class Track < ActiveRecord::Base
	attr_accessible :title, :track_file, :artist

	#this mounts the uploader to trackuploader, to the :track_file field specifically
	#:track_file represents the carrierwave uploader waiting on the server side
	mount_uploader :track_file, TrackUploader

	def random_number
		# While article i is not nil...
		max = Article.maximum(:id)
		id = rand(1..max)
		return id
	end

end
