# db/seeds.rb

# Clear existing data to avoid duplication
Exercise.delete_all

# Seed Exercises
exercises = [
  { 
    title: "Bench Press", 
    description: "A compound exercise that targets the chest, shoulders, and triceps.",  
    user_id: nil,  # Assuming this is a default exercise
    category: "upper",
    body_part_main: "Chest",
    body_part_accessory: nil
  },
  { 
    title: "Leg Press", 
    description: "A compound exercise targeting the quadriceps, hamstrings, and glutes.",
    user_id: nil,  # Assuming this is a default exercise
    category: "lower",
    body_part_main: "Quadriceps",
    body_part_accessory: nil
  },
  { 
    title: "Hex Bar Deadlift", 
    description: "A variation of the deadlift using a hexagonal barbell.",
    user_id: nil,  # Assuming this is a default exercise
    category: "full",
    body_part_main: "Back",
    body_part_accessory: nil
  },
  { 
    title: "Lat Pulldown", 
    description: "An exercise targeting the latissimus dorsi muscles in the back.",
    user_id: nil,  # Assuming this is a default exercise
    category: "upper",
    body_part_main: "Back",
    body_part_accessory: nil
  },
  { 
    title: "Shoulder Press", 
    description: "A compound exercise targeting the shoulders and upper arms.",
    user_id: nil,  # Assuming this is a default exercise
    category: "upper",
    body_part_main: "Shoulders",
    body_part_accessory: nil
  }
]

exercises.each do |exercise_attrs|
  Exercise.create!(exercise_attrs)
end

puts "Seeded #{Exercise.count} exercises."
