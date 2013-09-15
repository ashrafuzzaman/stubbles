# usually Date.today.cweek has a range of 1 .. 52
# But for the calculation purpose the range is shifted to 0 .. 51

class Week
	attr_accessor :week_number

	def initialize(week_number = default)
		@week_number = week_number.present? ? week_number.to_i : default
	end

	def beginning_of_week
		Date.commercial(relative_year, relative_week, 1)
	end

	def end_of_week
		Date.commercial(relative_year, relative_week, 7)
	end

	def previous
		@week_number - 1
	end

	def next
		@week_number + 1
	end

	def default
		Date.today.cweek - 1
	end

	private
	def relative_week
		(@week_number + 51) % 51 + 1
	end

	def relative_year
		Date.today.cwyear + (@week_number / 51)
	end

end