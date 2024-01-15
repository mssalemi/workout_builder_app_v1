# typed: true

module WorkoutBuilder
    class WorkoutBuilderWorkout
        extend T::Sig

        GoalUpdate = T.type_alias { { workout_exercise_id: Integer, new_goal: WorkoutBuilderExercise::Goal } }
        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer) } }


        sig { returns(T::Array[WorkoutBuilderExercise]) }
        attr_reader :exercises

        sig { returns(User) }
        attr_reader :user
        
        sig { returns(Integer) }
        attr_reader :id, :user_id

        sig { params(id: Integer, user_id: Integer, exercises: T::Array[WorkoutBuilderExercise]).void }
        def initialize(id:, user_id:, exercises: [])
            user = User.find_by(id: user_id)
            raise ActiveRecord::RecordNotFound if user.nil?

            @exercises = T.let(exercises, T::Array[WorkoutBuilderExercise])
            @user = user
            @id = T.let(1, Integer)
        end

        def save
            workout = Workout.create(user_id: @user.id, goal: {}, title: "Sample Workout")
            workout
        end

        sig { params(workout_id: Integer).returns(T.nilable(WorkoutBuilderWorkout)) }
        def self.load_from_db(workout_id:)
            workout_record = Workout.find_by(id: workout_id)
            return nil unless workout_record
        
            exercise_histories = ExerciseHistory.includes(:exercise).where(workout_id: workout_id)

            exercises = exercise_histories.map do |history_record|
                WorkoutBuilderExercise.new(
                    exercise_id: history_record.exercise_id,
                    exercise_history: history_record,
                    goal: history_record.performance_data.transform_keys(&:to_sym),
                    user_id: history_record.user_id,
                    completed: history_record.completed || false,
                )
            end

            # Initialize a new instance with the data from the workout_record
            workout_builder = new(id: workout_id, user_id: workout_record.user_id, exercises: exercises)
            workout_builder
        end
        # x = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: 1)

        private

        sig { params(id: String).returns(T.nilable(WorkoutBuilderExercise)) }
        def find_exercise(id:)
            @exercises.find { |exercise| exercise.id == id }
        end
    end 
end
