# typed: true

class ExerciseRepository
    extend T::Sig

    sig { params(user_id: Integer).void }
    def initialize(user_id:)
        @user_id = user_id
    end

    sig { params(filters: T::Hash[Symbol, T.untyped]).returns(T::Array[Exercise]) }
    def filter_exercises(filters = {})
        exercises = Exercise.where(user_id: @user_id).or(Exercise.where(user_id: nil))

        exercises = exercises.where('title LIKE ?', "%#{filters[:title]}%") if filters[:title].present?
        exercises = exercises.where(category: filters[:category]) if filters[:category].present?
        exercises = exercises.where(body_part_main: filters[:body_part_main]) if filters[:body_part_main].present?

        if filters[:body_part_accessory].present?
            # Use SQLite JSON_EXTRACT to query JSON data
            exercises = exercises.where("json_extract(body_part_accessory, '$.body_parts') LIKE ?", "%#{filters[:body_part_accessory]}%")
        end

        exercises.to_a
    end

    sig { params(exercise_id: Integer).returns(Exercise) }
    def find_by_id(exercise_id:)
        exercise = Exercise.find_by(id: exercise_id)

        raise ActiveRecord::RecordNotFound if exercise.nil? || (exercise.user_id.present? && exercise.user_id != @user_id)

        exercise
    end
end