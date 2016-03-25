class LucyController < ApplicationController
  def start
    $equipment = ""
  end

  def weaknesses
  	@lowerweaknesses = Weakness.where(bodypart: 'Lower body')
  	@upperweaknesses = Weakness.where(bodypart: 'Upper body')
  end

  def autoweaknesses
    current_user.weaknesses << Weakness.where(name: 'Hamstrings')
    current_user.weaknesses << Weakness.where(name: 'Hips')
    current_user.weaknesses << Weakness.where(name: 'Lower back')
    current_user.weaknesses << Weakness.where(name: 'Triceps')
    current_user.weaknesses << Weakness.where(name: 'Upper back')
    current_user.weaknesses << Weakness.where(name: 'Lats')
  	redirect_to lucy_timeframe_path
  end

  def weaknesses_post
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
  end

  def automaxeffort
    @maxLowerExercises = Array.new
    @maxUpperExercises = Array.new
    Variation.where(name: "Max effort").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any?)
        @maxLowerExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @maxUpperExercises.push(exercise)
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
    redirect_to lucy_dynamiceffort_path
  end

  def dynamiceffort
  end

  def autodynamiceffort
    @dynamicLowerSquatExercises = Array.new
    @dynamicLowerDeadliftExercises = Array.new
    @dynamicUpperExercises = Array.new
    Variation.where(name: "Dynamic effort").first.exercises.find_each do |exercise|
      if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(name: "Squat").any?)
        @dynamicLowerSquatExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(name: "Deadlift").any?)
        @dynamicLowerDeadliftExercises.push(exercise)
      elsif(exercise.weaknesses.where(bodypart: "Upper body").any?)
        @dynamicUpperExercises.push(exercise)
      end
    end

    @dynamicLowerSquatExercises = @dynamicLowerSquatExercises.sample($macrocycleLength)
    @dynamicLowerDeadliftExercises = @dynamicLowerDeadliftExercises.sample($macrocycleLength)
    @dynamicUpperExercises = @dynamicUpperExercises.sample($macrocycleLength)

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
    redirect_to lucy_repetitioneffort_path
  end

  def repetitioneffort
  end

  def autorepetitioneffort
    redirect_to lucy_repetitioneffort_path
  end

  def repetitioneffort_post
    redirect_to lucy_repetitioneffort_path
  end

  def warmup
  end
  
  def autowarmup
    redirect_to lucy_repetitioneffort_path
  end

  def warmup_post
    redirect_to lucy_repetitioneffort_path
  end

  def deload
  end
  
  def autodeload
    redirect_to lucy_repetitioneffort_path
  end

  def deload_post
    redirect_to lucy_repetitioneffort_path
  end

  def finish
  end
end
