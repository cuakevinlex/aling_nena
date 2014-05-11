class Reserve
	attr_reader :fname
	attr_writer :fname
	def initialize(fname, lname, email,room)
		@fname = fname
		@lname = lname
		@email = email
		@room = room
	end
	def say_my_name
		"Name: #{@fname} #{@lname}"
	end
	def say_my_email
		"E-mail: #{@email}<br />Room: #{@room}"
	end
		
end
