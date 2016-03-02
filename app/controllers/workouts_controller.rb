class WorkoutsController < ApplicationController
  def show
    @workout = Workout.find(params[:id])
  end
 
  def new
    @workout = Workout.new
    @exercises = Exercise.all
  end
 
  def edit
    @workout = Workout.find(params[:id])
    # Add logic to select exercises by method and body part
    @exercises = Exercise.all
  end
 
  def create
    @workout = Workout.new(workout_params)
 
    if @workout.save
      redirect_to @workout
    else
      render 'new'
    end
  end
 
  def update
    @workout = Workout.find(params[:id])
 
    if @workout.update(workout_params)
      redirect_to @workout
    else
      render 'edit'
    end
  end
 
  def destroy
    @workout = Workout.find(params[:id])
    @workout.destroy
 
    redirect_to workouts_path
  end
 
  private
    def workout_params
      params.require(:workout).permit(:name, :description)
    end
end
