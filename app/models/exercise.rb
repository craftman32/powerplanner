class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :workouts
	has_and_belongs_to_many :variations
	has_and_belongs_to_many :weaknesses
end
