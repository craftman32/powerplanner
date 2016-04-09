class MacrocyclesController < ApplicationController
  def index
    @macrocycles = Macrocycle.paginate(page: params[:page],:per_page => 10)
  end
 
  def show
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id
    
    @cycleWeek = 1
    @macrocycle = Macrocycle.find(params[:id])
  end
 
  def new
    @macrocycle = Macrocycle.new
  end
 
  def edit
    @macrocycle = Macrocycle.find(params[:id])
    @cycleWeek = 1

    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id
  end

  def editexercises
    @macrocycle = Macrocycle.find(params[:id])
    @macrocycleLength = @macrocycle.length
    @bars = Bar.all
    @boards = Board.all 
    @boxes = Box.all 
    @elevations = Elevation.all 
    @lowerMovements = [Movement.find_by_name("Squat"), Movement.find_by_name("Deadlift")]
    @positions = Position.all 
    @repRanges = Reprange.all 
    @tempos = [Tempo.find_by_name("No tempo"), Tempo.find_by_name("1 second pause"), Tempo.find_by_name("2 second pause"), Tempo.find_by_name("3 second pause")]

    @repBars = [Bar.find_by_name("Regular bar"), Bar.find_by_name("Dumbbell"), Bar.find_by_name("Curl bar"), Bar.find_by_name("Machine")]
    @lowerSupplementalMovements = [Movement.find_by_name("Reverse hyperextensions"), Movement.find_by_name("Glute ham raises"), Movement.find_by_name("Hamstring curls"), Movement.find_by_name("Ab crunches"), Movement.find_by_name("Pull throughs"), Movement.find_by_name("Good mornings"), Movement.find_by_name("Back extensions")]
    @lowerAccessoryMovements = @lowerSupplementalMovements
    @lowerPrehabMovements = @lowerSupplementalMovements
    @upperSupplementalMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Shoulder presses")]
    @upperAccessoryMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Shoulder presses"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
    @upperPrehabMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
    @repTempos = [Tempo.find_by_name("No tempo"), Tempo.find_by_name("2-0-2-0"), Tempo.find_by_name("2-1-1-0"), Tempo.find_by_name("0-1-0-0")]

    @lowerWarmupMovements = [Movement.find_by_name("Reverse hyperextensions"), Movement.find_by_name("Glute ham raises"), Movement.find_by_name("Hamstring curls"), Movement.find_by_name("Ab crunches"), Movement.find_by_name("Pull throughs"), Movement.find_by_name("Good mornings"), Movement.find_by_name("Back extensions")]
    @upperWarmupMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
  end
 
  def create
    @macrocycle = Macrocycle.new(macrocycle_params)
 	  @macrocycle.created_by = current_user.email
    if @macrocycle.save
      start_date = @macrocycle.macrocycle_start_date
      for i in 1..(@macrocycle.length / 4)
        @macrocycle.mesocycles.create(mesocycle_start_date: start_date)
        for i in 1..4
          @macrocycle.mesocycles.last.microcycles.create(microcycle_start_date: start_date)
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Max Effort Lower", workout_start_date: start_date)
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Max Effort Upper", workout_start_date: (start_date + 1))
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Dynamic Effort Lower", workout_start_date: (start_date + 3))
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Dynamic Effort Upper", workout_start_date: (start_date + 4))
          start_date = start_date + 7
        end
      end
      redirect_to @macrocycle
    else
      render 'new'
    end
  end
 
  def update
    @macrocycle = Macrocycle.find(params[:id])
 
    if @macrocycle.update(macrocycle_params)
      redirect_to @macrocycle
    else
      render 'edit'
    end
  end

  def editexercises_post
    @macrocycle = Macrocycle.find(params[:id])

    # Removing all the current exercises in the cycle
    @macrocycle.mesocycles.each do |mesocycle|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          workout.exercises.clear
        end
      end
    end
    
    # Saving the max effort exercises
    @maxLowerExercises = Array.new
    @maxUpperExercises = Array.new
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @benchId = Movement.find_by_name("Bench press").id

    for i in 1..$macrocycleLength
      if (Movement.find(params[:lowerMovement][i.to_s]).name == "Squat")
        @squatExercise = Exercise.where("reprange_id = ? AND position_id = ? AND movement_id = ? AND bar_id = ? AND box_id = ? AND  tempo_id = ? AND exercisemethod_id = ?", params[:lowerReprange][i.to_s], params[:lowerPosition][i.to_s], params[:lowerMovement][i.to_s], params[:lowerBar][i.to_s], params[:lowerBox][i.to_s], params[:lowerTempo][i.to_s], @maxEffortId)
        @maxLowerExercises.push(@squatExercise)

      elsif (Movement.find(params[:lowerMovement][i.to_s]).name == "Deadlift")
        @deadliftExercise = Exercise.where("reprange_id = ? AND position_id = ? AND movement_id = ? AND bar_id = ? AND elevation_id = ? AND exercisemethod_id = ?", params[:lowerReprange][i.to_s], params[:lowerPosition][i.to_s], params[:lowerMovement][i.to_s], params[:lowerBar][i.to_s], params[:lowerElevation][i.to_s], @maxEffortId)
        @maxLowerExercises.push(@deadliftExercise)
      end
    end

    for i in 1..$macrocycleLength
      @upperExercise = Exercise.where("reprange_id = ? AND position_id = ? AND movement_id = ? AND bar_id = ? AND board_id = ? AND  tempo_id = ? AND exercisemethod_id = ?", params[:upperReprange][i.to_s], params[:upperPosition][i.to_s], @benchId, params[:upperBar][i.to_s], params[:upperBoard][i.to_s], params[:upperTempo][i.to_s], @maxEffortId)
      @maxUpperExercises.push(@upperExercise)
    end

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, multiplier|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each_with_index do |workout, i|
          if(workout.workout_type == "Max Effort Lower")
            workout.exercises << @maxLowerExercises.pop
          elsif(workout.workout_type == "Max Effort Upper")
            workout.exercises << @maxUpperExercises.pop
          end
        end
      end
    end

    # Saving the dynamic effort exercises
    @dynamicLowerSquatExercises = Array.new
    @dynamicLowerDeadliftExercises = Array.new
    @dynamicUpperExercises = Array.new
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @squatId = Movement.find_by_name("Squat").id
    @deadliftId = Movement.find_by_name("Deadlift").id
    @benchId = Movement.find_by_name("Bench press").id

    for i in 1..($macrocycleLength / 4)
      @squatExercise = Exercise.where("position_id = ? AND movement_id = ? AND bar_id = ? AND box_id = ? AND exercisemethod_id = ?", params[:squatPosition][i.to_s], @squatId, params[:squatBar][i.to_s], params[:squatBox][i.to_s], @dynamicEffortId).first
      @dynamicLowerSquatExercises.push(@squatExercise)

      @deadliftExercise = Exercise.where("position_id = ? AND movement_id = ? AND bar_id = ? AND elevation_id = ? AND exercisemethod_id = ?", params[:deadliftPosition][i.to_s], @deadliftId, params[:deadliftBar][i.to_s], params[:deadliftElevation][i.to_s], @dynamicEffortId).first
      @dynamicLowerDeadliftExercises.push(@deadliftExercise)

      @upperExercise = Exercise.where("position_id = ? AND movement_id = ? AND bar_id = ? AND exercisemethod_id = ?", params[:benchPosition][i.to_s], @benchId, params[:benchBar][i.to_s], @dynamicEffortId).first
      @dynamicUpperExercises.push(@upperExercise)
    end

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          if(workout.workout_type == "Dynamic Effort Lower")
            workout.exercises << @dynamicLowerSquatExercises[i]
            workout.exercises << @dynamicLowerDeadliftExercises[i]
          elsif(workout.workout_type == "Dynamic Effort Upper")
            workout.exercises << @dynamicUpperExercises[i]
          end
        end
      end
    end

    # Saving the repetition effort exercises
    @lowerSupplementalExercises = Array.new
    @lowerAccessoryExercises = Array.new
    @lowerPrehabExercises = Array.new
    @upperSupplementalExercises = Array.new
    @upperAccessoryExercises = Array.new
    @upperPrehabExercises = Array.new

    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id

    for i in 1..($macrocycleLength / 4)
      @lowerSupplementalExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND exercisemethod_id = ?", params[:lowerSupplementalMovement][i.to_s], params[:lowerSupplementalTempo][i.to_s], @supplementalId).first
      @lowerSupplementalExercises.push(@lowerSupplementalExercise)

      @lowerPrehabExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND exercisemethod_id = ?", params[:lowerPrehabMovement][i.to_s], params[:lowerPrehabTempo][i.to_s], @prehabId).first
      @lowerPrehabExercises.push(@lowerPrehabExercise)

      @upperSupplementalExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND bar_id = ? AND exercisemethod_id = ?", params[:upperSupplementalMovement][i.to_s], params[:upperSupplementalTempo][i.to_s], params[:upperSupplementalBar][i.to_s], @supplementalId).first
      @upperSupplementalExercises.push(@upperSupplementalExercise)

      @upperPrehabExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND bar_id = ? AND exercisemethod_id = ?", params[:upperPrehabMovement][i.to_s], params[:upperPrehabTempo][i.to_s], params[:upperPrehabBar][i.to_s], @prehabId).first
      @upperPrehabExercises.push(@upperPrehabExercise)
    end

    for i in 1..($macrocycleLength / 2)
      @lowerAccessoryExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND exercisemethod_id = ?", params[:lowerAccessoryMovement][i.to_s], params[:lowerAccessoryTempo][i.to_s], @accessoryId).first
      @lowerAccessoryExercises.push(@lowerAccessoryExercise)

      @upperAccessoryExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND bar_id = ? AND exercisemethod_id = ?", params[:upperAccessoryMovement][i.to_s], params[:upperAccessoryTempo][i.to_s], params[:upperAccessoryBar][i.to_s], @accessoryId).first
      @upperAccessoryExercises.push(@upperAccessoryExercise)
    end

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          if(workout.workout_type == "Max Effort Lower" || workout.workout_type == "Dynamic Effort Lower")
            workout.exercises << @lowerSupplementalExercises[i]
            workout.exercises << @lowerAccessoryExercises[i]
            workout.exercises << @lowerAccessoryExercises[i + 1]
            workout.exercises << @lowerPrehabExercises[i]
          elsif(workout.workout_type == "Max Effort Upper" || workout.workout_type == "Dynamic Effort Upper")
            workout.exercises << @upperSupplementalExercises[i]
            workout.exercises << @upperAccessoryExercises[i]
            workout.exercises << @upperAccessoryExercises[i + 1]
            workout.exercises << @upperPrehabExercises[i]
          end
        end
      end
    end

    # Saving the warmup exercises
    @lowerWarmupExercises = Array.new
    @upperWarmupExercises = Array.new

    @warmupId = Exercisemethod.find_by_name("Warmup").id

    for i in 1..(($macrocycleLength / 4) * 3)
      @lowerWarmupExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND exercisemethod_id = ?", params[:lowerWarmupMovement][i.to_s], params[:lowerWarmupTempo][i.to_s], @warmupId).first
      @lowerWarmupExercises.push(@lowerWarmupExercise)

      @upperWarmupExercise = @upperPrehabExercise = Exercise.where("movement_id = ? AND tempo_id = ? AND bar_id = ? AND exercisemethod_id = ?", params[:upperWarmupMovement][i.to_s], params[:upperWarmupTempo][i.to_s], params[:upperWarmupBar][i.to_s], @warmupId).first      
      @upperWarmupExercises.push(@upperWarmupExercise)
    end

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          if(workout.workout_type == "Max Effort Lower" || workout.workout_type == "Dynamic Effort Lower")
            workout.exercises << @lowerWarmupExercises[i]
            workout.exercises << @lowerWarmupExercises[i + 1]
            workout.exercises << @lowerWarmupExercises[i + 2]
          elsif(workout.workout_type == "Max Effort Upper" || workout.workout_type == "Dynamic Effort Upper")
            workout.exercises << @upperWarmupExercises[i]
            workout.exercises << @upperWarmupExercises[i + 1]
            workout.exercises << @upperWarmupExercises[i + 2]
          end
        end
      end
    end
    redirect_to edit_macrocycle_path(@macrocycle)
  end
 
  def destroy
    @macrocycle = Macrocycle.find(params[:id])
    @macrocycle.destroy
 
    redirect_to macrocycles_path
  end

  private
    def macrocycle_params
      params.require(:macrocycle).permit(:name, :description, :length, :macrocycle_start_date)
    end
end