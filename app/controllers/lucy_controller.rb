class LucyController < ApplicationController
  def start
    $equipment = ""
  end

  def weaknesses
  	@lowerweaknesses = Weakness.where(bodypart: 'Lower body')
  	@upperweaknesses = Weakness.where(bodypart: 'Upper body')
  end

  def autoweaknesses
    current_user.weaknesses.clear
    current_user.weaknesses << Weakness.where(name: 'Hamstrings')
    current_user.weaknesses << Weakness.where(name: 'Hips')
    current_user.weaknesses << Weakness.where(name: 'Lower back')
    current_user.weaknesses << Weakness.where(name: 'Triceps')
    current_user.weaknesses << Weakness.where(name: 'Upper back')
    current_user.weaknesses << Weakness.where(name: 'Lats')
  	redirect_to lucy_timeframe_path
  end

  def weaknesses_post
    current_user.weaknesses.clear
    @lowerweaknesses = Weakness.find(params[:lowerweaknesses])
    @upperweaknesses = Weakness.find(params[:upperweaknesses])

    @lowerweaknesses.each do |weakness|
      current_user.weaknesses << weakness
    end
    @upperweaknesses.each do |weakness|
      current_user.weaknesses << weakness
    end
  	redirect_to lucy_timeframe_path
  end

  def timeframe
  end

  def timeframe_post
    current_user.macrocycles.clear
    @macrocycle = Macrocycle.new
    $macrocycleLength = Integer(params[:length])
    start_date = Date.civil(params[:macrocycle_start_date][:year].to_i, params[:macrocycle_start_date][:month].to_i, params[:macrocycle_start_date][:day].to_i)
    @macrocycle.length = params[:length]
    @macrocycle.macrocycle_start_date = start_date
    @macrocycle.created_by = current_user.email
    @macrocycle.name = "My Lucy Macrocycle"
    @macrocycle.description = "I created this macrocycle with help from Lucy!"
    if @macrocycle.save
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
    end
    $lucyMacrocycle = Macrocycle.last
    $lucyMacrocycle.users << current_user
    redirect_to lucy_equipment_path
  end

  def equipment
  end

  def commercialequipment
    $equipment = "Commercial"
    redirect_to lucy_maxeffort_path
  end

  def powerliftingequipment
    $equipment = "Powerlifting"
    redirect_to lucy_maxeffort_path
  end

  def maxeffort
    @bars = Bar.all
    @boards = Board.all 
    @boxes = Box.all 
    @elevations = Elevation.all 
    @lowerMovements = [Movement.find_by_name("Squat"), Movement.find_by_name("Deadlift")]
    @positions = Position.all 
    @repRanges = Reprange.all 
    @tempos = [Tempo.find_by_name(""), Tempo.find_by_name("1 second pause"), Tempo.find_by_name("2 second pause"), Tempo.find_by_name("3 second pause")]
  end

  def automaxeffort
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @regularBarId = Bar.find_by_name("Regular bar").id
    @noBoardId = Board.find_by_name("").id
    @floorId = Board.find_by_name("Floor").id
    @pinAtChestId = Board.find_by_name("Pin at the chest").id
    @pinAboveChestId = Board.find_by_name("Pin 3 inches above the chest").id
    @squatId = Movement.find_by_name("Squat").id
    @deadliftId = Movement.find_by_name("Deadlift").id
    @benchId = Movement.find_by_name("Bench press").id
    @boardVariations = [@noBoardId, @floorId, @pinAtChestId, @pinAboveChestId]

    if $equipment == "Commercial"
      @maxLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @maxEffortId, @squatId, @regularBarId).order("RANDOM()").limit($macrocycleLength / 2).to_a
      @maxLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @maxEffortId, @deadliftId, @regularBarId).order("RANDOM()").limit($macrocycleLength / 2).to_a
      @maxUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ? AND board_id IN (?)", @maxEffortId, @benchId, @regularBarId, @boardVariations).order("RANDOM()").limit($macrocycleLength).to_a
    elsif $equipment == "Powerlifting"
      @maxLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @squatId).order("RANDOM()").limit($macrocycleLength / 2).to_a
      @maxLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @deadliftId).order("RANDOM()").limit($macrocycleLength / 2).to_a
      @maxUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @benchId).order("RANDOM()").limit($macrocycleLength / 2).to_a
    end

    @maxLowerExercises = @maxLowerSquatExercises + @maxLowerDeadliftExercises
    @maxLowerExercises.shuffle

    $lucyMacrocycle.mesocycles.each do |mesocycle|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          if(workout.workout_type == "Max Effort Lower")
            workout.exercises << @maxLowerExercises.pop
          elsif(workout.workout_type == "Max Effort Upper")
            workout.exercises << @maxUpperExercises.pop
          end
        end
      end
    end
    redirect_to lucy_dynamiceffort_path
  end

  def maxeffort_post
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
    redirect_to lucy_dynamiceffort_path
  end

  def dynamiceffort
    @bars = Bar.all
    @boards = Board.all 
    @boxes = Box.all 
    @elevations = Elevation.all 
    @positions = Position.all 
  end

  def autodynamiceffort
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @regularBarId = Bar.find_by_name("Regular bar").id
    @noBoardId = Board.where(name: "")
    @floorId = Board.where(name:"Floor")
    @pinAtChestId = Board.where(name:"Pin at the chest")
    @pinAboveChestId = Board.where(name:"Pin 3 inches above the chest")
    @squatId = Movement.find_by_name("Squat").id
    @deadliftId = Movement.find_by_name("Deadlift").id
    @benchId = Movement.find_by_name("Bench press").id

    if $equipment == "Commercial"
      @dynamicLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @squatId, @regularBarId).order("RANDOM()").limit($macrocycleLength / 4).to_a
      @dynamicLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @deadliftId, @regularBarId).order("RANDOM()").limit($macrocycleLength / 4).to_a
      @dynamicUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @benchId, @regularBarId).order("RANDOM()").limit($macrocycleLength / 4).to_a
    elsif $equipment == "Powerlifting"
      @dynamicLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @squatId).order("RANDOM()").limit($macrocycleLength / 4).to_a
      @dynamicLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @deadliftId).order("RANDOM()").limit($macrocycleLength / 4).to_a
      @dynamicUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @benchId).order("RANDOM()").limit($macrocycleLength / 4).to_a
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
    redirect_to lucy_repetitioneffort_path
  end

  def dynamiceffort_post
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
    redirect_to lucy_repetitioneffort_path
  end

  def repetitioneffort
    @bars = [Bar.find_by_name("Regular bar"), Bar.find_by_name("Dumbbell"), Bar.find_by_name("Curl bar")]
    @lowerSupplementalMovements = [Movement.find_by_name("Reverse hyperextensions"), Movement.find_by_name("Glute ham raises"), Movement.find_by_name("Hamstring curls"), Movement.find_by_name("Ab crunches"), Movement.find_by_name("Pull throughs"), Movement.find_by_name("Good mornings"), Movement.find_by_name("Back extensions")]
    @lowerAccessoryMovements = @lowerSupplementalMovements
    @lowerPrehabMovements = @lowerSupplementalMovements
    @upperSupplementalMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Dips"), Movement.find_by_name("Shoulder presses"), Movement.find_by_name("Pushups"), Movement.find_by_name("Pushups")]
    @upperAccessoryMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Dips"), Movement.find_by_name("Shoulder presses"), Movement.find_by_name("Pushups"), Movement.find_by_name("Pushups"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
    @upperPrehabMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Pushups"), Movement.find_by_name("Pushups"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
    @tempos = [Tempo.find_by_name(""), Tempo.find_by_name("2-0-2-0"), Tempo.find_by_name("2-1-1-0"), Tempo.find_by_name("0-1-0-0")]
  end

  def autorepetitioneffort
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id

    @lowerBodyWeaknesses = Array.new
    @upperBodyWeaknesses = Array.new
    current_user.weaknesses.each do |weakness|
      if weakness.bodypart == "Lower body"
        @lowerBodyWeaknesses.push(weakness.id)
      elsif weakness.bodypart == "Upper body"
        @upperBodyWeaknesses.push(weakness.id)
      end
    end

    @lowerSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @lowerBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 4).to_a
    @lowerAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @lowerBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 2).to_a
    @lowerPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @lowerBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 4).to_a

    @upperSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @upperBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 4).to_a
    @upperAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @upperBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 2).to_a
    @upperPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @upperBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit($macrocycleLength / 4).to_a

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
    redirect_to lucy_warmup_path
  end

  def repetitioneffort_post
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
    redirect_to lucy_warmup_path
  end

  def warmup
    @bars = [Bar.find_by_name("Regular bar"), Bar.find_by_name("Dumbbell"), Bar.find_by_name("Curl bar")]
    @lowerWarmupMovements = [Movement.find_by_name("Reverse hyperextensions"), Movement.find_by_name("Glute ham raises"), Movement.find_by_name("Hamstring curls"), Movement.find_by_name("Ab crunches"), Movement.find_by_name("Pull throughs"), Movement.find_by_name("Good mornings"), Movement.find_by_name("Back extensions")]
    @upperWarmupMovements = [Movement.find_by_name("Tricep extensions"), Movement.find_by_name("Rows"), Movement.find_by_name("Pulldowns"), Movement.find_by_name("Curls"), Movement.find_by_name("Pushups"), Movement.find_by_name("Pushups"), Movement.find_by_name("Face pulls"), Movement.find_by_name("Rear delt flies")]
    @tempos = [Tempo.find_by_name(""), Tempo.find_by_name("2-0-2-0"), Tempo.find_by_name("2-1-1-0"), Tempo.find_by_name("0-1-0-0")]
  end
  
  def autowarmup
    @warmupId = Exercisemethod.find_by_name("Warmup").id

    @lowerBodyWeaknesses = Array.new
    @upperBodyWeaknesses = Array.new
    current_user.weaknesses.each do |weakness|
      if weakness.bodypart == "Lower body"
        @lowerBodyWeaknesses.push(weakness.id)
      elsif weakness.bodypart == "Upper body"
        @upperBodyWeaknesses.push(weakness.id)
      end
    end

    @lowerWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @lowerBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit(($macrocycleLength / 4) * 3).to_a

    @upperWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @upperBodyWeaknesses).references(:exercises_weaknesses).order("RANDOM()").limit(($macrocycleLength / 4) * 3).to_a

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
    redirect_to lucy_deload_path
  end

  def warmup_post
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
    redirect_to lucy_deload_path
  end

  def deload
  end
  
  def autodeload
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.last.workouts.each do |workout|
        workout.exercises.each do |exercise|
          if (i == 0)
            if(exercise.exercisemethod_id == @maxEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(i == 1)
            if(exercise.exercisemethod_id == @dynamicEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(i == 2)
            if(exercise.exercisemethod_id == @supplementalId || exercise.exercisemethod_id == @accessoryId || exercise.exercisemethod_id == @prehabId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          end
        end
      end
    end
    redirect_to lucy_finish_path
  end

  def deload_post
    @deloadOptions = Array.new
    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      @deloadOptions.push(params["mesocycleDeloadOption#{i}"])
    end

    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.last.workouts.each do |workout|
        workout.exercises.each do |exercise|
          if (@deloadOptions[i] == "1")
            if(exercise.exercisemethod_id == @maxEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(@deloadOptions[i] == "2")
            if(exercise.exercisemethod_id == @dynamicEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(@deloadOptions[i] == "3")
            if(exercise.exercisemethod_id == @supplementalId || exercise.exercisemethod_id == @accessoryId || exercise.exercisemethod_id == @prehabId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          end
        end
      end
    end

    redirect_to lucy_finish_path
  end

  def finish
  end

  def about
  end
end