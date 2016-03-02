class Microcycle < ActiveRecord::Base
	belongs_to :mesocycle
	has_many :workouts, dependent: :destroy
end
