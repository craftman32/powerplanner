####################################################################################################
####################################################################################################
# This makes all the exercise variations, exercises, and weakness records used in the application  #
# This current version makes 3754 exercises (3-30-2016)                                            #
####################################################################################################
####################################################################################################

# Making all the variations
# Making the bar variations
accessoryBars = Array.new
mainBars = Array.new
Bar.create(name:"Machine")
accessoryBars.push(Bar.last)
Bar.create(name:"Regular bar")
accessoryBars.push(Bar.last)
mainBars.push(Bar.last)
Bar.create(name:"Squat bar")
mainBars.push(Bar.last)
Bar.create(name:"Deadlift bar")
mainBars.push(Bar.last)
Bar.create(name:"Safety squat bar")
mainBars.push(Bar.last)
Bar.create(name:"Cambered bar")
mainBars.push(Bar.last)
Bar.create(name:"Dumbbell")
accessoryBars.push(Bar.last)
Bar.create(name:"Curl bar")
accessoryBars.push(Bar.last)

# Making the board variations
Board.create(name:"No board")
Board.create(name:"1-board")
Board.create(name:"2-board")
Board.create(name:"3-board")
Board.create(name:"Floor")
Board.create(name:"Pin at the chest")
Board.create(name:"Pin 3 inches above the chest")

# Making the box variations
Box.create(name:"No box")
Box.create(name:"Low box")
Box.create(name:"Parallel box")
Box.create(name:"High box")

# Making the elevation variations
Elevation.create(name:"No elevation")
Elevation.create(name:"3-inch deficit")
Elevation.create(name:"2-inch deficit")
Elevation.create(name:"1-inch deficit")
Elevation.create(name:"1-inch block")
Elevation.create(name:"2-inch block")
Elevation.create(name:"3-inch block")
Elevation.create(name:"Box at the knee")
Elevation.create(name:"Box above the knee")
Elevation.create(name:"Rack at the knee")
Elevation.create(name:"Rack above the knee")

# Making the equipment variations
Equipment.create(name:"Knee wraps")
Equipment.create(name:"Briefs")
Equipment.create(name:"Suit with straps down")
Equipment.create(name:"Suit with straps up")
Equipment.create(name:"Bench shirt")
Equipment.create(name:"Slingshot")

# Making the machine variations
Machine.create(name:"Cable")
Machine.create(name:"Reverse hyperextension")
Machine.create(name:"Glute ham raise")
Machine.create(name:"Lat pulldown")

# Making the method variations
mainMethods = Array.new
Exercisemethod.create(name:"Max effort")
mainMethods.push(Exercisemethod.last)
Exercisemethod.create(name:"Dynamic effort")
mainMethods.push(Exercisemethod.last)
repetitionEffortMethods = Array.new
Exercisemethod.create(name:"Repetition effort - supplemental")
repetitionEffortMethods.push(Exercisemethod.last)
Exercisemethod.create(name:"Repetition effort - accessory")
repetitionEffortMethods.push(Exercisemethod.last)
Exercisemethod.create(name:"Repetition effort - prehab")
repetitionEffortMethods.push(Exercisemethod.last)
Exercisemethod.create(name:"Warmup")
repetitionEffortMethods.push(Exercisemethod.last)

# Making the movement variations
# Main movements
mainMovements = Array.new
Movement.create(name:"Squat")
mainMovements.push(Movement.last)
Movement.create(name:"Bench press")
mainMovements.push(Movement.last)
Movement.create(name:"Deadlift")
mainMovements.push(Movement.last)

# Accessories
# Lower body
lowerAccessoryMovements = Array.new
Movement.create(name:"Reverse hyperextensions")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Glute ham raises")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Hamstring curls")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Ab crunches")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Pull throughs")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Good mornings")
lowerAccessoryMovements.push(Movement.last)
Movement.create(name:"Back extensions")
lowerAccessoryMovements.push(Movement.last)

# Upper body
upperAccessoryMovements = Array.new
Movement.create(name:"Tricep extensions")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Rows")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Pulldowns")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Curls")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Dips")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Shoulder presses")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Pushups")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Face pulls")
upperAccessoryMovements.push(Movement.last)
Movement.create(name:"Rear delt flies")
upperAccessoryMovements.push(Movement.last)

# Making the positions
Position.create(name:"Close")
Position.create(name:"Regular")
Position.create(name:"Wide")

# Making the tempos
maxEffortTempos = Array.new
repetitionEffortTempos = Array.new
Tempo.create(name:"No tempo")
maxEffortTempos.push(Tempo.last)
repetitionEffortTempos.push(Tempo.last)
Tempo.create(name:"1 second pause")
maxEffortTempos.push(Tempo.last)
Tempo.create(name:"2 second pause")
maxEffortTempos.push(Tempo.last)
Tempo.create(name:"3 second pause")
maxEffortTempos.push(Tempo.last)

Tempo.create(name:"2-0-2-0")
repetitionEffortTempos.push(Tempo.last)
Tempo.create(name:"2-1-1-0")
repetitionEffortTempos.push(Tempo.last)
Tempo.create(name:"0-1-0-0")
repetitionEffortTempos.push(Tempo.last)

# Making the tensions
Tension.create(name:"Micro bands")
Tension.create(name:"Mini bands")
Tension.create(name:"Monster mini bands")
Tension.create(name:"Light bands")
Tension.create(name:"Average bands")
Tension.create(name:"Heavy bands")
Tension.create(name:"Big chains")
Tension.create(name:"Small chains")

# Making the max effort rep ranges
Reprange.create(name:"1RM")
Reprange.create(name:"3RM")
Reprange.create(name:"5RM")

################################################################################################
# Making the weaknesses
Weakness.create(name: "Hamstrings", bodypart: "Lower body")
Weakness.create(name: "Hips", bodypart: "Lower body")
Weakness.create(name: "Lower back", bodypart: "Lower body")
Weakness.create(name: "Glutes", bodypart: "Lower body")
Weakness.create(name: "Abs", bodypart: "Lower body")
Weakness.create(name: "Quads", bodypart: "Lower body")
Weakness.create(name: "Triceps", bodypart: "Upper body")
Weakness.create(name: "Upper back", bodypart: "Upper body")
Weakness.create(name: "Lats", bodypart: "Upper body")
Weakness.create(name: "Shoulders", bodypart: "Upper body")
Weakness.create(name: "Chest", bodypart: "Upper body")
Weakness.create(name: "Biceps", bodypart: "Upper body")
################################################################################################
# Making some starting exercises and associating them with variations and weaknesses
################################################################################################

# Starting a loop to have the computer make exercises
# Making all the main exercises
mainMovements.each do |movement|
	Position.all.each do |position|
		mainBars.each do |bar|
			mainMethods.each do |method|
				Reprange.all.each do |maxEffortRepRange|
					maxEffortTempos.each do |pauseCount|
						# Making the max effort and dynamic effort main movements
						# Making all the squat exercises
						if(movement.name == "Squat" && bar.name != "Deadlift bar")
							Box.all.each do |box|
								exercise = Exercise.new
								exerciseName = ""
								if(method.name == "Max effort")
									exercise.reprange_id = maxEffortRepRange.id
									exercise.tempo_id = pauseCount.id
									exerciseName << maxEffortRepRange.name + " " + pauseCount.name + " "
								end
								exercise.movement_id = movement.id
								exercise.exercisemethod_id = method.id
								exercise.position_id = position.id
								exercise.bar_id = bar.id
								exercise.box_id = box.id
								exercise.weaknesses << Weakness.where(bodypart: "Lower body")
								exerciseName << method.name + " " + position.name + " stance " + bar.name + " " + box.name + " " + movement.name
								exercise.name = exerciseName.capitalize
								exercise.save
							end
						elsif(movement.name == "Bench press" && bar.name != "Deadlift bar" && bar.name != "Safety squat bar")
							Board.all.each do |board|
								exercise = Exercise.new
								exerciseName = ""
								if(method.name == "Max effort")
									exercise.reprange_id = maxEffortRepRange.id
									exercise.tempo_id = pauseCount.id
									exerciseName << maxEffortRepRange.name + " " + pauseCount.name + " "
								end
								exercise.movement_id = movement.id
								exercise.exercisemethod_id = method.id
								exercise.position_id = position.id
								exercise.bar_id = bar.id
								exercise.board_id = board.id
								exercise.weaknesses << Weakness.where(bodypart: "Upper body")
								exerciseName << method.name + " " + position.name + " grip " + bar.name + " " + board.name + " " + movement.name
								exercise.name = exerciseName.capitalize
								exercise.save
							end
						elsif(movement.name == "Deadlift" && bar.name != "Safety squat bar" && bar.name != "Cambered bar")
							Elevation.all.each do |elevation|
								exercise = Exercise.new
								exerciseName = ""
								if(method.name == "Max effort")
									exercise.reprange_id = maxEffortRepRange.id
									exerciseName << maxEffortRepRange.name + " "
								end
								exercise.movement_id = movement.id
								exercise.exercisemethod_id = method.id
								exercise.position_id = position.id
								exercise.bar_id = bar.id
								exercise.elevation_id = elevation.id
								exercise.weaknesses << Weakness.where(bodypart: "Lower body")
								exerciseName << method.name + " " + position.name + " stance " + bar.name + " " + elevation.name + " " + movement.name
								exercise.name = exerciseName.capitalize
								exercise.save
							end					
						end
					end
				end
			end
		end
	end
end

# Making all the accessory exercises
# Lower body accessories
lowerAccessoryMovements.each do |movement|
	repetitionEffortTempos.each do |tempo|
		repetitionEffortMethods.each do |method|
			if(movement.name == "Reverse hyperextensions")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Glute ham raises")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Hamstring curls")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Ab crunches")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Abs")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Pull throughs")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hips")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Good mornings")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Back extensions")
				exercise = Exercise.new
				exercise.exercisemethod_id = method.id
				exercise.tempo_id = tempo.id
				exercise.movement_id = movement.id
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			end
		end
	end
end

# Upper body accessories
upperAccessoryMovements.each do |movement|
	accessoryBars.each do |bar|
		repetitionEffortTempos.each do |tempo|
			repetitionEffortMethods.each do |method|
				if(movement.name == "Tricep extensions")
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Rows")
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exercise.weaknesses << Weakness.where(name: "Lats")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Pulldowns" && bar.name == "Machine")
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exercise.weaknesses << Weakness.where(name: "Lats")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Curls")
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Biceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Shoulder presses" && method.name != "Repetition effort - prehab" && method.name != "Warmup")
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Shoulders")
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif((movement.name == "Face pulls" && bar.name == "Machine") || (movement.name == "Rear delt flies" && bar.name == "Dumbbell" && method.name != "Repetition effort - supplemental"))
					exercise = Exercise.new
					exercise.exercisemethod_id = method.id
					exercise.bar_id = bar.id
					exercise.tempo_id = tempo.id
					exercise.movement_id = movement.id
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				end
			end
		end
	end
end