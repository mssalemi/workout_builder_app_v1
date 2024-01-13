# typed: false

class ExerciseService
    def initialize(user_id:)
        @user_id = user_id
        @exercise_repository = ExerciseRepository.new(user_id: @user_id)
    end

    def find_by_id(exercise_id:)
        @exercise_repository.find_by_id(exercise_id: exercise_id)
    end

    def find_with_filters(filters: {})
      @exercise_repository.filter_exercises(filters)
    end
end