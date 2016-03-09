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

  def manualweaknesses
  	redirect_to lucy_timeframe_path
  end

  def timeframe
  end

  def timeframe_post
    @macrocycle = Macrocycle.new
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
end
