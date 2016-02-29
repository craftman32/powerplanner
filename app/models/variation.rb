class Variation < ActiveRecord::Base
	belongs_to :variationType
	has_and_belongs_to_many :exercises
end
