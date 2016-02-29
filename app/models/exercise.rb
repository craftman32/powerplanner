class Exercise < ActiveRecord::Base
	belongs_to :workoutset
	has_and_belongs_to_many :variations
	has_and_belongs_to_many :weaknesses
end
