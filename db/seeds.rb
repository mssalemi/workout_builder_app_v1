# db/seeds.rb

# Clear existing data to avoid duplication
Exercise.delete_all

# Seed Exercises
exercises = [
  { 
    title: "Bench Press",
    description: "A compound exercise that targets the chest, shoulders, and triceps.",
    category: "upper",
    body_part_main: "Chest",
    body_part_accessory: { body_parts: ["Shoulders", "Triceps"] }
  },
  { 
    title: "Lat Pulldown",
    description: "An exercise targeting the latissimus dorsi muscles in the back.",
    category: "upper",
    body_part_main: "Back",
    body_part_accessory: { body_parts: ["Biceps"] }
  },
  { 
    title: "Straight Arm Pulldown",
    description: "An exercise targeting the upper back and lats.",
    category: "upper",
    body_part_main: "Back",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Machine Shoulder Press",
    description: "A compound exercise targeting the shoulders and upper arms.",
    category: "upper",
    body_part_main: "Shoulders",
    body_part_accessory: { body_parts: ["Triceps"] }
  },
  { 
    title: "Cable Row",
    description: "An exercise focusing on the muscles of the back and biceps.",
    category: "upper",
    body_part_main: "Back",
    body_part_accessory: { body_parts: ["Biceps"] }
  },
  { 
    title: "Tricep Pushdown",
    description: "An isolation exercise targeting the triceps.",
    category: "upper",
    body_part_main: "Triceps",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Bicep Curl",
    description: "An exercise primarily targeting the biceps.",
    category: "upper",
    body_part_main: "Biceps",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Lateral Raise",
    description: "Targets the deltoid muscles of the shoulder.",
    category: "upper",
    body_part_main: "Shoulders",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Ab Crunch",
    description: "A core exercise targeting the abdominal muscles.",
    category: "full",
    body_part_main: "Abdominals",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Leg Press",
    description: "A compound exercise targeting the quadriceps, hamstrings, and glutes.",
    category: "lower",
    body_part_main: "Quadriceps",
    body_part_accessory: { body_parts: ["Hamstrings", "Glutes"] }
  },
  { 
    title: "Quad Extension",
    description: "An isolation exercise focusing on the quadriceps.",
    category: "lower",
    body_part_main: "Quadriceps",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Leg Curl",
    description: "Targets hamstrings at the back of the leg.",
    category: "lower",
    body_part_main: "Hamstrings",
    body_part_accessory: { body_parts: [] }
  },
  { 
    title: "Calf Raise",
    description: "An exercise focusing on the calf muscles.",
    category: "lower",
    body_part_main: "Calves",
    body_part_accessory: { body_parts: [] }
  }
]

exercises.each do |exercise_attrs|
  Exercise.create!(exercise_attrs)
end

puts "Seeded #{Exercise.count} exercises."
