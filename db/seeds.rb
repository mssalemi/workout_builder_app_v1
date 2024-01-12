# db/seeds.rb

# Clear existing data to avoid duplication
Exercise.delete_all

# Seed Exercises
exercises = [
  { title: "Bench Press", description: "A compound exercise that targets the chest, shoulders, and triceps." },
  { title: "Leg Press", description: "A compound exercise targeting the quadriceps, hamstrings, and glutes." },
  { title: "Hex Bar Deadlift", description: "A variation of the deadlift using a hexagonal barbell." },
  { title: "Lat Pulldown", description: "An exercise targeting the latissimus dorsi muscles in the back." },
  { title: "Shoulder Press", description: "A compound exercise targeting the shoulders and upper arms." }
]

exercises.each do |exercise_attrs|
  Exercise.create!(exercise_attrs)
end

puts "Seeded #{Exercise.count} exercises."
