class ExercisesController < ApplicationController
  def index
    @exercises = Exercise.paginate(page: params[:page],:per_page => 25)
  end

  def show
    @exercise = Exercise.find(params[:id])
  end
 
  def new
    @exercise = Exercise.new
    @variation_types = VariationType.all
  end
 
  def edit
    @variation_types = VariationType.all
    @exercise = Exercise.find(params[:id])
  end
 
  def create
    @exercise = Exercise.new(exercise_params)
 
    if @exercise.save
      redirect_to @exercise
    else
      render 'new'
    end
  end
 
  def update
    @exercise = Exercise.find(params[:id])
 
    if @exercise.update(exercise_params)
      redirect_to @exercise
    else
      render 'edit'
    end
  end
 
  def destroy
    @exercise = Exercise.find(params[:id])
    @exercise.destroy
 
    redirect_to exercises_path
  end
 
  private
    def exercise_params
      params.require(:exercise).permit(:name, :description, variation_ids:[])
    end
end