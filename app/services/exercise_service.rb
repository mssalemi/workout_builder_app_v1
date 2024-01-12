# typed: true

class ExerciseService
    def self.filter_exercises(filters = {})
      exercises = Exercise.all
  
      exercises = exercises.where('title LIKE ?', "%#{filters[:title]}%") if filters[:title].present?
      exercises = exercises.where(category: filters[:category]) if filters[:category].present?
      exercises = exercises.where(body_part_main: filters[:body_part_main]) if filters[:body_part_main].present?
  
      if filters[:body_part_accessory].present?
        # Use SQLite JSON_EXTRACT to query JSON data
        exercises = exercises.where("json_extract(body_part_accessory, '$.body_parts') LIKE ?", "%#{filters[:body_part_accessory]}%")
      end
  
      exercises
    end
end