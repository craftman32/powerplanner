class MacrocyclesController < ApplicationController
  def index
    @macrocycles = Macrocycle.all
  end
 
  def show
    @macrocycle = Macrocycle.find(params[:id])
  end
 
  def new
    @macrocycle = Macrocycle.new
  end
 
  def edit
    @macrocycle = Macrocycle.find(params[:id])
  end
 
  def create
    @macrocycle = Macrocycle.new(macrocycle_params)
 	  @macrocycle.created_by = current_user.email
    if @macrocycle.save
      for i in 1..(@macrocycle.length / 4)
        @macrocycle.mesocycles.create
        for i in 1..4
          @macrocycle.mesocycles.last.microcycles.create
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Max Effort Lower")
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Max Effort Upper")
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Dynamic Effort Lower")
          @macrocycle.mesocycles.last.microcycles.last.workouts.create(workout_type: "Dynamic Effort Upper")
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
      params.require(:macrocycle).permit(:name, :description, :length)
    end
end
