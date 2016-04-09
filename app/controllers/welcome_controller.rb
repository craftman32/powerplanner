class WelcomeController < ApplicationController
  def index
    @maxEffortId = Exercisemethod.find_by_name("Max effort").id
    @dynamicEffortId = Exercisemethod.find_by_name("Dynamic effort").id
    @supplementalId = Exercisemethod.find_by_name("Repetition effort - supplemental").id
    @accessoryId = Exercisemethod.find_by_name("Repetition effort - accessory").id
    @prehabId = Exercisemethod.find_by_name("Repetition effort - prehab").id
    @warmupId = Exercisemethod.find_by_name("Warmup").id
    
  	@d = Date.today
  	@beginDate = @d.at_beginning_of_week
  	@endDate = @d.at_beginning_of_week + 7
  	@currentMicrocycle = ""
  	@cycleWeek = 1
  	if current_user.macrocycles.any?
  		@currentMacrocycle = current_user.macrocycles.last
  		@currentMacrocycle.mesocycles.each do |mesocycle|
  			mesocycle.microcycles.each  do |microcycle|
  				if (microcycle.microcycle_start_date >= @beginDate && microcycle.microcycle_start_date <= @endDate)
  					@currentMicrocycle = microcycle
  					return
  				else
  					@cycleWeek = @cycleWeek + 1
  				end
  			end
  		end
  	end
  end

  def about
  end
end
