class Workout < ActiveRecord::Base
	belongs_to :microcycle
	has_and_belongs_to_many :exercises
end
