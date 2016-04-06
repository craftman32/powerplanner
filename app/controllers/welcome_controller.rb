class WelcomeController < ApplicationController
  def index
  	@maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id

    @regularBarId = Bar.find_by_name("Regular bar").id
    @noBoardId = Board.find_by_name("").id
    @floorId = Board.find_by_name("Floor").id
    @pinAtChestId = Board.find_by_name("Pin at the chest").id
    @pinAboveChestId = Board.find_by_name("Pin 3 inches above the chest").id
    @squatId = Movement.find_by_name("Squat").id
    @deadliftId = Movement.find_by_name("Deadlift").id
    @benchId = Movement.find_by_name("Bench press").id
    @boardVariations = [@noBoardId, @floorId, @pinAtChestId, @pinAboveChestId]

    @lowerBodyWeaknesses = Array.new
    @upperBodyWeaknesses = Array.new
    current_user.weaknesses.each do |weakness|
      if weakness.bodypart == "Lower body"
        @lowerBodyWeaknesses.push(weakness.id)
      elsif weakness.bodypart == "Upper body"
        @upperBodyWeaknesses.push(weakness.id)
      end
    end
    @maxUpperExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND movement_id = ? AND exercises_weaknesses.weakness_id IN (?) AND board_id IN (?)", @maxEffortId, @benchId, @upperBodyWeaknesses, @boardVariations).references(:exercises_weaknesses).paginate(page: params[:page],:per_page => 25)

  	@d = Date.today
  	@beginDate = @d.at_beginning_of_week
  	@endDate = @d.at_beginning_of_week + 7
  	@currentMicrocycle = ""
  	@cycleWeek = 1
  	if current_user.macrocycles.any?
  		@currentMacrocycle = current_user.macrocycles.last
  		@currentMacrocycle.mesocycles.each do |mesocycle|
  			mesocycle.microcycles.each  do |microcycle|
  				if (microcycle.microcycle_start_date >= @beginDate && microcycle.microcycle_start_date <= @endDate)
  					@currentMicrocycle = microcycle
  					return
  				else
  					@cycleWeek = @cycleWeek + 1
  				end
  			end
  		end
  	end
  end

  def about
  end
end
