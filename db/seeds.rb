# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#Making the variation categories
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
Variation.create(name:"Regular bar", variation_type_id:bar)
Variation.create(name:"Squat bar", variation_type_id:bar)
Variation.create(name:"Deadlift bar", variation_type_id:bar)
Variation.create(name:"Safety squat bar", variation_type_id:bar)
Variation.create(name:"Cambered bar", variation_type_id:bar)
Variation.create(name:"Dumbbell", variation_type_id:bar)
Variation.create(name:"Curl bar", variation_type_id:bar)

# Making the board variations
Variation.create(name:"1-board", variation_type_id:board)
Variation.create(name:"2-board", variation_type_id:board)
Variation.create(name:"3-board", variation_type_id:board)

# Making the box variations
Variation.create(name:"Low box", variation_type_id:box)
Variation.create(name:"Parallel box", variation_type_id:box)
Variation.create(name:"High box", variation_type_id:box)

# Making the elevation variations
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
Variation.create(name:"Repetition effort - supplemental", variation_type_id:method)
Variation.create(name:"Repetition effort - accessory", variation_type_id:method)
Variation.create(name:"Repetition effort - prehab", variation_type_id:method)

# Making the movement variations
Variation.create(name:"Squat", variation_type_id:movement)
Variation.create(name:"Bench press", variation_type_id:movement)
Variation.create(name:"Deadlift", variation_type_id:movement)