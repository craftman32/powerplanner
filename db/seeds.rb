# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Making the variation categories
VariationType.create(name:"Bar")
bar = VariationType.last.id

VariationType.create(name:"Board")
board = VariationType.last.id

VariationType.create(name:"Box")
box = VariationType.last.id

VariationType.create(name:"Elevation")
elevation = VariationType.last.id

VariationType.create(name:"Equipment")
equipment = VariationType.last.id

VariationType.create(name:"Machine")
machine = VariationType.last.id

VariationType.create(name:"Method")
method = VariationType.last.id

VariationType.create(name:"Movement")
movement = VariationType.last.id

VariationType.create(name:"Position")
position = VariationType.last.id

VariationType.create(name:"Tempo")
tempo = VariationType.last.id

VariationType.create(name:"Tension")
tension = VariationType.last.id

# Making all the variations
# Making the bar variations
accessoryBars = Array.new
Variation.create(name:"Regular bar", variation_type_id:bar)
accessoryBars.push(Variation.last)
Variation.create(name:"Squat bar", variation_type_id:bar)
Variation.create(name:"Deadlift bar", variation_type_id:bar)
Variation.create(name:"Safety squat bar", variation_type_id:bar)
Variation.create(name:"Cambered bar", variation_type_id:bar)
Variation.create(name:"Dumbbell", variation_type_id:bar)
accessoryBars.push(Variation.last)
Variation.create(name:"Curl bar", variation_type_id:bar)
accessoryBars.push(Variation.last)

# Making the board variations
Variation.create(name:"", variation_type_id:board)
Variation.create(name:"1-board", variation_type_id:board)
Variation.create(name:"2-board", variation_type_id:board)
Variation.create(name:"3-board", variation_type_id:board)

# Making the box variations
Variation.create(name:"", variation_type_id:box)
Variation.create(name:"Low box", variation_type_id:box)
Variation.create(name:"Parallel box", variation_type_id:box)
Variation.create(name:"High box", variation_type_id:box)

# Making the elevation variations
Variation.create(name:"", variation_type_id:elevation)
Variation.create(name:"3-inch deficit", variation_type_id:elevation)
Variation.create(name:"2-inch deficit", variation_type_id:elevation)
Variation.create(name:"1-inch deficit", variation_type_id:elevation)
Variation.create(name:"1-inch block", variation_type_id:elevation)
Variation.create(name:"2-inch block", variation_type_id:elevation)
Variation.create(name:"3-inch block", variation_type_id:elevation)
Variation.create(name:"Box at the knee", variation_type_id:elevation)
Variation.create(name:"Box above the knee", variation_type_id:elevation)
Variation.create(name:"Rack at the knee", variation_type_id:elevation)
Variation.create(name:"Rack above the knee", variation_type_id:elevation)

# Making the equipment variations
Variation.create(name:"Knee wraps", variation_type_id:equipment)
Variation.create(name:"Briefs", variation_type_id:equipment)
Variation.create(name:"Suit with straps down", variation_type_id:equipment)
Variation.create(name:"Suit with straps up", variation_type_id:equipment)
Variation.create(name:"Bench shirt", variation_type_id:equipment)
Variation.create(name:"Slingshot", variation_type_id:equipment)

# Making the machine variations
Variation.create(name:"Cable", variation_type_id:machine)
Variation.create(name:"Reverse hyperextension", variation_type_id:machine)
Variation.create(name:"Glute ham raise", variation_type_id:machine)
Variation.create(name:"Lat pulldown", variation_type_id:machine)

# Making the method variations
Variation.create(name:"Max effort", variation_type_id:method)
Variation.create(name:"Dynamic effort", variation_type_id:method)
repetitionEffortMethods = Array.new
Variation.create(name:"Repetition effort - supplemental", variation_type_id:method)
repetitionEffortMethods.push(Variation.last)
Variation.create(name:"Repetition effort - accessory", variation_type_id:method)
repetitionEffortMethods.push(Variation.last)
Variation.create(name:"Repetition effort - prehab", variation_type_id:method)
repetitionEffortMethods.push(Variation.last)

# Making the movement variations
# Main movements
mainMovements = Array.new
Variation.create(name:"Squat", variation_type_id:movement)
mainMovements.push(Variation.last)
Variation.create(name:"Bench press", variation_type_id:movement)
mainMovements.push(Variation.last)
Variation.create(name:"Deadlift", variation_type_id:movement)
mainMovements.push(Variation.last)

# Accessories
# Lower body
lowerAccessoryMovements = Array.new
Variation.create(name:"Reverse hyperextensions", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Glute ham raises", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Hamstring curls", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Ab crunches", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Pull throughs", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Good mornings", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)
Variation.create(name:"Back extensions", variation_type_id:movement)
lowerAccessoryMovements.push(Variation.last)

# Upper body
upperAccessoryMovements = Array.new
Variation.create(name:"Tricep extensions", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Rows", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Pulldowns", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Curls", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Dips", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Shoulder presses", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Pushups", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Face pulls", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)
Variation.create(name:"Rear delt flies", variation_type_id:movement)
upperAccessoryMovements.push(Variation.last)

# Making the positions
Variation.create(name:"Close", variation_type_id:position)
Variation.create(name:"Regular", variation_type_id:position)
Variation.create(name:"Wide", variation_type_id:position)

# Making the tempos
Variation.create(name:"", variation_type_id:tempo)
Variation.create(name:"2-0-2-0", variation_type_id:tempo)
Variation.create(name:"2-3-1-0", variation_type_id:tempo)
Variation.create(name:"3-0-1-0", variation_type_id:tempo)
Variation.create(name:"2-1-1-0", variation_type_id:tempo)
Variation.create(name:"0-1-0-0", variation_type_id:tempo)
Variation.create(name:"0-2-0-0", variation_type_id:tempo)
Variation.create(name:"0-3-0-0", variation_type_id:tempo)

# Making the tensions
Variation.create(name:"Micro bands", variation_type_id:tension)
Variation.create(name:"Mini bands", variation_type_id:tension)
Variation.create(name:"Monster mini bands", variation_type_id:tension)
Variation.create(name:"Light bands", variation_type_id:tension)
Variation.create(name:"Average bands", variation_type_id:tension)
Variation.create(name:"Heavy bands", variation_type_id:tension)
Variation.create(name:"Big chains", variation_type_id:tension)
Variation.create(name:"Small chains", variation_type_id:tension)
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
	VariationType.find(position).variations.each do |position|
		VariationType.find(bar).variations.each do |bar|
			VariationType.find(method).variations.each do |method|
				# Making the max effort and dynamic effort main movements
				# Making all the squat exercises
				if(movement.name == "Squat" && bar.name != "Deadlift bar" && bar.name != "Dumbbell" && bar.name != "Curl bar" && (method.name == "Max effort" || method.name == "Dynamic effort"))
					VariationType.find(box).variations.each do |box|
						exercise = Exercise.new
						exercise.variations << movement
						exercise.variations << method
						exercise.variations << position
						exercise.variations << bar
						exercise.variations << box
						exercise.weaknesses << Weakness.where(bodypart: "Lower body")
						exerciseName = method.name + " " + position.name + " stance " + bar.name + " " + box.name + " " + movement.name
						exercise.name = exerciseName.capitalize
						exercise.save
					end
				elsif(movement.name == "Bench press" && bar.name != "Deadlift bar" && bar.name != "Safety squat bar" && bar.name != "Dumbbell" && bar.name != "Curl bar" && bar.name != "Cambered bar" && (method.name == "Max effort" || method.name == "Dynamic effort"))
					VariationType.find(board).variations.each do |board|
						exercise = Exercise.new
						exercise.variations << movement
						exercise.variations << method
						exercise.variations << position
						exercise.variations << bar
						exercise.variations << board
						exercise.weaknesses << Weakness.where(bodypart: "Upper body")
						exerciseName = method.name + " " + position.name + " grip " + bar.name + " " + board.name + " " + movement.name
						exercise.name = exerciseName.capitalize
						exercise.save
					end
				elsif(movement.name == "Deadlift" && bar.name != "Safety squat bar" && bar.name != "Dumbbell" && bar.name != "Curl bar" && bar.name != "Cambered bar" && (method.name == "Max effort" || method.name == "Dynamic effort"))
					VariationType.find(elevation).variations.each do |elevation|
						exercise = Exercise.new
						exercise.variations << movement
						exercise.variations << method
						exercise.variations << position
						exercise.variations << bar
						exercise.variations << elevation
						exercise.weaknesses << Weakness.where(bodypart: "Lower body")
						exerciseName = method.name + " " + position.name + " stance " + bar.name + " " + elevation.name + " " + movement.name
						exercise.name = exerciseName.capitalize
						exercise.save
					end					
				end
			end
		end
	end
end

# Making all the accessory exercises
# Lower body accessories
lowerAccessoryMovements.each do |movement|
	VariationType.find(tempo).variations.each do |tempo|
		repetitionEffortMethods.each do |method|
			if(movement.name == "Reverse hyperextensions")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Glute ham raises")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Hamstring curls")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Ab crunches")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Abs")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Pull throughs")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hips")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Good mornings")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
				exercise.weaknesses << Weakness.where(name: "Lower back")
				exercise.weaknesses << Weakness.where(name: "Glutes")
				exercise.weaknesses << Weakness.where(name: "Hamstrings")
				exerciseName = method.name + " " + tempo.name + " " + movement.name
				exercise.name = exerciseName.capitalize
				exercise.save
			elsif(movement.name == "Back extensions")
				exercise = Exercise.new
				exercise.variations << method
				exercise.variations << tempo
				exercise.variations << movement
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
		VariationType.find(tempo).variations.each do |tempo|
			repetitionEffortMethods.each do |method|
				if(movement.name == "Tricep extensions")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << bar
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Rows" && bar.name != "Curl bar")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << bar
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exercise.weaknesses << Weakness.where(name: "Lats")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Pulldowns")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exercise.weaknesses << Weakness.where(name: "Lats")
					exerciseName = method.name + " " + tempo.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Curls")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << bar
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Biceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Dips" && method.name != "Repetition effort - prehab")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exercise.weaknesses << Weakness.where(name: "Shoulders")
					exerciseName = method.name + " " + tempo.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Shoulder presses" && bar.name != "Curl bar" && method.name != "Repetition effort - prehab")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << bar
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Shoulders")
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exerciseName = method.name + " " + tempo.name + " " + bar.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Pushups")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Triceps")
					exercise.weaknesses << Weakness.where(name: "Chest")
					exercise.weaknesses << Weakness.where(name: "Shoulders")
					exerciseName = method.name + " " + tempo.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				elsif(movement.name == "Face pulls" || movement.name == "Rear delt flies" && method.name != "Repetition effort - supplemental")
					exercise = Exercise.new
					exercise.variations << method
					exercise.variations << tempo
					exercise.variations << movement
					exercise.weaknesses << Weakness.where(name: "Upper back")
					exerciseName = method.name + " " + tempo.name + " " + movement.name
					exercise.name = exerciseName.capitalize
					exercise.save
				end
			end
		end
	end
end