class Exercise < ActiveRecord::Base
	has_and_belongs_to_many :workouts
	belongs_to :bar
	belongs_to :board
	belongs_to :box
	belongs_to :elevation
	has_and_belongs_to_many :equipment
	belongs_to :exercisemethod
	belongs_to :machine
	belongs_to :movement
	belongs_to :position
	belongs_to :reprange
	belongs_to :tempo
	belongs_to :tensions
	has_and_belongs_to_many :weaknesses
end