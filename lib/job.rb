class Job
	include ActiveModel::Conversion

	attr_accessor :class, :method, :args

	def initialize(options)
		options.each do |opt|
			self.send("#{opt.first}=, opt.last")
		end
	end
end
