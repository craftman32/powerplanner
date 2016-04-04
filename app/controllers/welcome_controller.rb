class WelcomeController < ApplicationController
  def index
  	@d = Date.today
	@beginDate = @d.at_beginning_of_week
	@endDate = @d.at_beginning_of_week + 7
	@currentMicrocycle = ""
	if current_user.macrocycles.any?
		@currentMacrocycle = current_user.macrocycles.last
		@currentMacrocycle.mesocycles.each do |mesocycle|
			mesocycle.microcycles.each do |microcycle|
				if (microcycle.microcycle_start_date >= @beginDate && microcycle.microcycle_start_date <= @endDate)
					@currentMicrocycle = microcycle
				end
			end
		end
	end
	@maxEffortId = Variation.find_by_name("Max effort").id
	@regularBarId = Variation.find_by_name("Regular bar").id
	@lowerBodyWeaknesses = Array.new
	@upperBodyWeaknesses = Array.new
	current_user.weaknesses.each do |weakness|
		if weakness.bodypart == "Lower body"
			@lowerBodyWeaknesses.push(weakness.id)
		elsif weakness.bodypart == "Upper body"
			@upperBodyWeaknesses.push(weakness.id)
		end
	end
	@maxLowerBodyExercises = Exercise.joins(:exercises_weaknesses, :exercises_variations).where("exercises_variations.variation_id = ? AND exercises_weaknesses.weakness_id IN (?)", @maxEffortId, @lowerBodyWeaknesses).order("RANDOM()").limit(10)
	@maxUpperBodyExercises = Exercise.joins(:exercises_weaknesses, :exercises_variations).where("exercises_variations.variation_id = ? AND exercises_weaknesses.weakness_id IN (?)", @maxEffortId, @upperBodyWeaknesses).order("RANDOM()").limit(10)
  end

  def about
  end
end
