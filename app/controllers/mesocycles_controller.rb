class MesocyclesController < ApplicationController
	before_filter :load_macrocycle
	def edit
		@mesocycle = Mesocycle.find(params[:id])

		@maxEffortId = Exercisemethod.find_by_name("Max effort").id
	    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
	    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
	    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
	    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
	    @warmupId = Exercisemethod.find_by_name("Warmup").id

		@squatId = Movement.find_by_name("Squat").id
		@deadliftId = Movement.find_by_name("Deadlift").id
		@benchId = Movement.find_by_name("Bench press").id

		@lowerBodyWeaknesses = Array.new
	    @upperBodyWeaknesses = Array.new
	    current_user.weaknesses.each do |weakness|
	      if weakness.bodypart == "Lower body"
	        @lowerBodyWeaknesses.push(weakness.id)
	      elsif weakness.bodypart == "Upper body"
	        @upperBodyWeaknesses.push(weakness.id)
	      end
	    end

		@maxLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @squatId)
		@maxLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @deadliftId)
		@maxUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @benchId)

		@dynamicLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @squatId)
		@dynamicLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @deadliftId)
		@dynamicUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @benchId)

		@lowerSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @lowerBodyWeaknesses).references(:exercises_weaknesses)
		@lowerAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @lowerBodyWeaknesses).references(:exercises_weaknesses)
		@lowerPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @lowerBodyWeaknesses).references(:exercises_weaknesses)

		@upperSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @upperBodyWeaknesses).references(:exercises_weaknesses)
		@upperAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @upperBodyWeaknesses).references(:exercises_weaknesses)
		@upperPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @upperBodyWeaknesses).references(:exercises_weaknesses)

		@lowerWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @lowerBodyWeaknesses).references(:exercises_weaknesses)
    	@upperWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @upperBodyWeaknesses).references(:exercises_weaknesses)
	end

	def update
	end
	private
		def load_macrocycle
		  $macrocycle = Macrocycle.find(params[:macrocycle_id])
		end
end
