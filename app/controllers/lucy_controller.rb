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
    @maxLowerSquatExercises = Array.new
    @maxLowerDeadliftExercises = Array.new
    @maxUpperExercises = Array.new
    @regularBarId = Variation.where(name: "Regular bar")
    @noBoardId = Variation.where(name: "")
    @squatId = Variation.where(name: "Squat")
    @deadliftId = Variation.where(name: "Deadlift")
    @floorId = Variation.where(name:"Floor")
    @pinAtChestId = Variation.where(name:"Pin at the chest")
    @pinAboveChestId = Variation.where(name:"Pin 3 inches above the chest")
    if $equipment == 'Commercial'
      Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any? && exercise.variations.where(id: @regularBarId).any?)
          @maxLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any? && exercise.variations.where(id: @regularBarId).any?)
          @maxLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any? && exercise.variations.where(id: @regularBarId).any? && (exercise.variations.where(id: @noBoardId).any? || exercise.variations.where(id: @floorId).any? || exercise.variations.where(id: @pinAtChestId).any? || exercise.variations.where(id: @pinAboveChestId).any?))
          @maxUpperExercises.push(exercise)
        end
      end
    elsif $equipment == 'Powerlifting'
      Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any?)
          @maxLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any?)
          @maxLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
          @maxUpperExercises.push(exercise)
        end
      end
    end
  end

  def automaxeffort
    @maxLowerExercises = Array.new
    @maxUpperExercises = Array.new
    @regularBarId = Variation.where(name: "Regular bar")
    @noBoardId = Variation.where(name: "")

    if $equipment == 'Commercial'
      Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @regularBarId).any?)
          @maxLowerExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any? && exercise.variations.where(id: @regularBarId).any? && (exercise.variations.where(id: @noBoardId).any? || exercise.variations.where(id: @floorId).any? || exercise.variations.where(id: @pinAtChestId).any? || exercise.variations.where(id: @pinAboveChestId).any?))
          @maxUpperExercises.push(exercise)
        end
      end
    elsif $equipment == 'Powerlifting'
        Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any?)
          @maxLowerExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
          @maxUpperExercises.push(exercise)
        end
      end
    end

    @maxLowerExercises = @maxLowerExercises.sample($macrocycleLength)
    @maxUpperExercises = @maxUpperExercises.sample($macrocycleLength)

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
    @dynamicLowerSquatExercises = Array.new
    @dynamicLowerDeadliftExercises = Array.new
    @dynamicUpperExercises = Array.new
    @regularBarId = Variation.where(name: "Regular bar")
    @squatId = Variation.where(name: "Squat")
    @deadliftId = Variation.where(name: "Deadlift")

    @noBoardId = Variation.where(name: "")
    @floorId = Variation.where(name:"Floor")
    @pinAtChestId = Variation.where(name:"Pin at the chest")
    @pinAboveChestId = Variation.where(name:"Pin 3 inches above the chest")

    if $equipment == 'Commercial'
      Variation.where(name: "Dynamic effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any? && exercise.variations.where(id: @regularBarId).any?)
          @dynamicLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any? && exercise.variations.where(id: @regularBarId).any?)
          @dynamicLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any? && exercise.variations.where(id: @regularBarId).any? && (exercise.variations.where(id: @noBoardId).any? || exercise.variations.where(id: @floorId).any? || exercise.variations.where(id: @pinAtChestId).any? || exercise.variations.where(id: @pinAboveChestId).any?))
          @dynamicUpperExercises.push(exercise)
        end
      end
    elsif $equipment == 'Powerlifting'
      Variation.where(name: "Dynamic effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any?)
          @dynamicLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any?)
          @dynamicLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
          @dynamicUpperExercises.push(exercise)
        end
      end
    end
  end

  def autodynamiceffort
    @dynamicLowerSquatExercises = Array.new
    @dynamicLowerDeadliftExercises = Array.new
    @dynamicUpperExercises = Array.new
    @regularBarId = Variation.where(name: "Regular bar")
    @squatId = Variation.where(name: "Squat")
    @deadliftId = Variation.where(name: "Deadlift")

    @noBoardId = Variation.where(name: "")
    @floorId = Variation.where(name:"Floor")
    @pinAtChestId = Variation.where(name:"Pin at the chest")
    @pinAboveChestId = Variation.where(name:"Pin 3 inches above the chest")

    if $equipment == 'Commercial'
      Variation.where(name: "Dynamic effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any? && exercise.variations.where(id: @regularBarId).any?)
          @dynamicLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any? && exercise.variations.where(id: @regularBarId).any?)
          @dynamicLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any? && exercise.variations.where(id: @regularBarId).any? && (exercise.variations.where(id: @noBoardId).any? || exercise.variations.where(id: @floorId).any? || exercise.variations.where(id: @pinAtChestId).any? || exercise.variations.where(id: @pinAboveChestId).any?))
          @dynamicUpperExercises.push(exercise)
        end
      end
    elsif $equipment == 'Powerlifting'
      Variation.where(name: "Dynamic effort").first.exercises.find_each do |exercise|
        if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @squatId).any?)
          @dynamicLowerSquatExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(id: @deadliftId).any?)
          @dynamicLowerDeadliftExercises.push(exercise)
        elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
          @dynamicUpperExercises.push(exercise)
        end
      end
    end

    @dynamicLowerSquatExercises = @dynamicLowerSquatExercises.sample($macrocycleLength / 4)
    @dynamicLowerDeadliftExercises = @dynamicLowerDeadliftExercises.sample($macrocycleLength / 4)
    @dynamicUpperExercises = @dynamicUpperExercises.sample($macrocycleLength / 4)

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
    @lowerSupplementalExercises = Array.new
    @lowerAccessoryExercises = Array.new
    @lowerPrehabExercises = Array.new
    @upperSupplementalExercises = Array.new
    @upperAccessoryExercises = Array.new
    @upperPrehabExercises = Array.new
    Variation.where(name: "Repetition effort - supplemental").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerSupplementalExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperSupplementalExercises.push(exercise)
      end
    end
    Variation.where(name: "Repetition effort - accessory").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerAccessoryExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperAccessoryExercises.push(exercise)
      end
    end
    Variation.where(name: "Repetition effort - prehab").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerPrehabExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperPrehabExercises.push(exercise)
      end
    end
  end

  def autorepetitioneffort
    @lowerSupplementalExercises = Array.new
    @lowerAccessoryExercises = Array.new
    @lowerPrehabExercises = Array.new
    @upperSupplementalExercises = Array.new
    @upperAccessoryExercises = Array.new
    @upperPrehabExercises = Array.new
    Variation.where(name: "Repetition effort - supplemental").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerSupplementalExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperSupplementalExercises.push(exercise)
      end
    end
    Variation.where(name: "Repetition effort - accessory").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerAccessoryExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperAccessoryExercises.push(exercise)
      end
    end
    Variation.where(name: "Repetition effort - prehab").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerPrehabExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperPrehabExercises.push(exercise)
      end
    end

    @lowerSupplementalExercises = @lowerSupplementalExercises.sample($macrocycleLength / 4)
    @lowerAccessoryExercises = @lowerAccessoryExercises.sample($macrocycleLength / 2)
    @lowerPrehabExercises = @lowerPrehabExercises.sample($macrocycleLength / 4)
    @upperSupplementalExercises = @upperSupplementalExercises.sample($macrocycleLength / 4)
    @upperAccessoryExercises = @upperAccessoryExercises.sample($macrocycleLength / 2)
    @upperPrehabExercises = @upperPrehabExercises.sample($macrocycleLength / 4)

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
    @lowerWarmupExercises = Array.new
    @upperWarmupExercises = Array.new
    Variation.where(name: "Repetition effort - prehab").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerWarmupExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperWarmupExercises.push(exercise)
      end
    end
  end
  
  def autowarmup
    @lowerWarmupExercises = Array.new
    @upperWarmupExercises = Array.new
    Variation.where(name: "Repetition effort - prehab").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @lowerWarmupExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @upperWarmupExercises.push(exercise)
      end
    end

    @lowerWarmupExercises = @lowerWarmupExercises.sample(($macrocycleLength / 4) * 3)
    @upperWarmupExercises = @upperWarmupExercises.sample(($macrocycleLength / 4) * 3)

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
    $lucyMacrocycle.mesocycles.each do |mesocycle|
      mesocycle.microcycles.last.workouts.each do |workout|
        workout.exercises.each do |exercise|
          if(exercise.variations.where(name: "Max effort").any?)
            workout.exercises.delete(Exercise.find(exercise))
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

    $lucyMacrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.last.workouts.each do |workout|
        workout.exercises.each do |exercise|
          if (@deloadOptions[i] == "1")
            if(exercise.variations.where(name: "Max effort").any?)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(@deloadOptions[i] == "2")
            if(exercise.variations.where(name: "Dynamic effort").any?)
              workout.exercises.delete(Exercise.find(exercise))
            end
          elsif(@deloadOptions[i] == "3")
            if(exercise.variations.where(name: "Repetition effort - supplemental").any? || exercise.variations.where(name: "Repetition effort - accessory").any? || exercise.variations.where(name: "Repetition effort - prehab").any?)
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