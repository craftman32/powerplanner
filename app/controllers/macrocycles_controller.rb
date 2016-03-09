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
