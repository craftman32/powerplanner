class MesocyclesController < ApplicationController
	before_filter :load_macrocycle
	def edit
		@mesocycle = Mesocycle.find(params[:id])
		@maxLowerSquatExercises = Array.new
	    @squatId = Variation.where(name: "Squat")

		Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
			if(exercise.variations.where(id: @squatId).any?)
				@maxLowerSquatExercises.push(exercise)
			end
		end
	end

	def update
	end
	private
		def load_macrocycle
		  $macrocycle = Macrocycle.find(params[:macrocycle_id])
		end
end
