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
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @regularBarId = Bar.find_by_name("Regular bar").id
    @noBoardId = Board.where(name: "")
    @floorId = Board.where(name:"Floor")
    @pinAtChestId = Board.where(name:"Pin at the chest")
    @pinAboveChestId = Board.where(name:"Pin 3 inches above the chest")
    @squatId = Movement.find_by_name("Squat").id
    @deadliftId = Movement.find_by_name("Deadlift").id
    @benchId = Movement.find_by_name("Bench press").id

    if $equipment == "Commercial"
      @maxLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @maxEffortId, @squatId, @regularBarId)
      @maxLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @maxEffortId, @deadliftId, @regularBarId)
      @maxUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @maxEffortId, @benchId, @regularBarId)
    elsif $equipment == "Powerlifting"
      @maxLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @squatId).paginate(page: params[:page],:per_page => 25)
      @maxLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @deadliftId).paginate(page: params[:page],:per_page => 25)
      @maxUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @maxEffortId, @benchId).paginate(page: params[:page],:per_page => 25)
    end
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
    @maxLowerSquatExercises = Exercise.find(params[:maxLowerSquatExercises])
    @maxLowerDeadliftExercises = Exercise.find(params[:maxLowerDeadliftExercises])
    @maxLowerExercises = @maxLowerSquatExercises + @maxLowerDeadliftExercises
    @maxLowerExercises.shuffle
    @maxUpperExercises = Exercise.find(params[:maxUpperExercises])

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, multiplier|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each_with_index do |workout, i|
          if(workout.workout_type == "Max Effort Lower")
            workout.exercises << @maxLowerExercises[i + (multiplier * 4)]
          elsif(workout.workout_type == "Max Effort Upper")
            workout.exercises << @maxUpperExercises[i + (multiplier * 4)]
          end
        end
      end
    end
    redirect_to lucy_dynamiceffort_path
  end

  def dynamiceffort
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
      @dynamicLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @squatId, @regularBarId).paginate(page: params[:page],:per_page => 25)
      @dynamicLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @deadliftId, @regularBarId).paginate(page: params[:page],:per_page => 25)
      @dynamicUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ? AND bar_id = ?", @dynamicEffortId, @benchId, @regularBarId).paginate(page: params[:page],:per_page => 25)
    elsif $equipment == "Powerlifting"
      @dynamicLowerSquatExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @squatId).paginate(page: params[:page],:per_page => 25)
      @dynamicLowerDeadliftExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @deadliftId).paginate(page: params[:page],:per_page => 25)
      @dynamicUpperExercises = Exercise.where("exercisemethod_id = ? AND movement_id = ?", @dynamicEffortId, @benchId).paginate(page: params[:page],:per_page => 25)
    end
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
    @dynamicLowerSquatExercises = Exercise.find(params[:dynamicLowerSquatExercises])
    @dynamicLowerDeadliftExercises = Exercise.find(params[:dynamicLowerDeadliftExercises])
    @dynamicUpperExercises = Exercise.find(params[:dynamicUpperExercises])

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

    @lowerSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @lowerBodyWeaknesses).references(:exercises_weaknesses)
    @lowerAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @lowerBodyWeaknesses).references(:exercises_weaknesses)
    @lowerPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @lowerBodyWeaknesses).references(:exercises_weaknesses)

    @upperSupplementalExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @supplementalId, @upperBodyWeaknesses).references(:exercises_weaknesses)
    @upperAccessoryExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @accessoryId, @upperBodyWeaknesses).references(:exercises_weaknesses)
    @upperPrehabExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @prehabId, @upperBodyWeaknesses).references(:exercises_weaknesses)
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
    @lowerSupplementalExercises = Exercise.find(params[:lowerSupplementalExercises])
    @lowerAccessoryExercises = Exercise.find(params[:lowerAccessoryExercises])
    @lowerPrehabExercises = Exercise.find(params[:lowerPrehabExercises])
    @upperSupplementalExercises = Exercise.find(params[:upperSupplementalExercises])
    @upperAccessoryExercises = Exercise.find(params[:upperAccessoryExercises])
    @upperPrehabExercises = Exercise.find(params[:upperPrehabExercises])

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

    @lowerWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @lowerBodyWeaknesses).references(:exercises_weaknesses)

    @upperWarmupExercises = Exercise.includes(:exercises_weaknesses).where("exercisemethod_id = ? AND exercises_weaknesses.weakness_id IN (?)", @warmupId, @upperBodyWeaknesses).references(:exercises_weaknesses)
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
    @lowerWarmupExercises = Exercise.find(params[:lowerWarmupExercises])
    @upperWarmupExercises = Exercise.find(params[:upperWarmupExercises])

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
          if (deloadOptions[i] == "1")
            if(exercise.exercisemethod_id == @maxEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(deloadOptions[i] == "2")
            if(exercise.exercisemethod_id == @dynamicEffortId)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(deloadOptions[i] == "3")
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