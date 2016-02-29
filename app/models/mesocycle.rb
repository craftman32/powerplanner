class Mesocycle < ActiveRecord::Base
	belongs_to :macrocycle
	has_many :microcycles
end
