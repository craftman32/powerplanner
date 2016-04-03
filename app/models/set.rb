class Set < ActiveRecord::Base
	has_many :workouts
	has_many :exercises
end
