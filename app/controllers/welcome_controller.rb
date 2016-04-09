class WelcomeController < ApplicationController
  def index
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
