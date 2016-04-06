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
    @maxLowerSquatExercises = Array.new
    @maxLowerDeadliftExercises = Array.new
    @maxLowerExercises = Array.new
    @maxUpperExercises = Array.new
    @squatId = Variation.where(name: "Squat")
    @deadliftId = Variation.where(name: "Deadlift")
    @benchId = Variation.where(name: "Bench press")

    @macrocycle.mesocycles.each_with_index do |mesocycle, i|
      mesocycle.microcycles.each do |microcycle|
        microcycle.workouts.each do |workout|
          workout.exercises.each do |exercise|
            if(exercise.weaknesses.where(bodypart: "Lower body").any? && exercise.variations.where(name: "Max effort").any?)
              @maxLowerExercises.push(exercise)
            elsif(exercise.weaknesses.where(bodypart: "Upper body").any? && exercise.variations.where(name: "Max effort").any?)
              @maxUpperExercises.push(exercise)
            end
          end
        end
      end
    end
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