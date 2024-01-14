# typed: true

module WorkoutBuilder
    class WorkoutBuilderWorkout
        extend T::Sig

        GoalUpdate = T.type_alias { { workout_exercise_id: Integer, new_goal: WorkoutBuilderExercise::Goal } }
        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer) } }


        sig { returns(T::Array[WorkoutBuilderExercise]) }
        attr_reader :exercises
        
        sig { returns(Integer) }
        attr_reader :id, :user_id

        sig { params(user_id: Integer).void }
        def initialize(user_id:)
            user = User.find_by(id: user_id)
            raise ActiveRecord::RecordNotFound if user.nil?

            @exercise_service = ExerciseService.new(user_id: user_id)
            @exercises = T.let([], T::Array[WorkoutBuilderExercise])
            @user = user
            @id = T.let(1, Integer)
        end

        sig { params(exercise_id: Integer, goal: T.nilable(Goal)).returns(WorkoutBuilderExercise) }
        def add_exercise(exercise_id:, goal:)
            default_goal = { weight: nil, reps: nil, sets: nil }
            effective_goal = goal || default_goal

            workout_exercise = WorkoutBuilderExercise.new(
                exercise_id: exercise_id,
                goal: effective_goal
            )

            @exercises << workout_exercise

            workout_exercise
        end

        sig { params(id: String).void }
        def remove_exercise(id:)
            @exercises.delete_if { |exercise| exercise.id == id }
        end

        sig { params(goal_updates: T::Array[GoalUpdate]).void }
        def bulk_update_workout_goals(goal_updates)
            goal_updates.each do |update|
                exercise = @exercises.find { |exercise| exercise.id == update[:workout_exercise_id] }
                next unless exercise
    
                exercise.update_goal(update[:new_goal])
            end
        end

        sig { void }
        def complete_workout
            @exercises.each do |exercise|
                exercise.complete_exercise(workout_id: @id, user_id: @user_id)
            end
        end

        def save
            workout = Workout.create(user_id: @user.id, goal: {}, title: "Sample Workout")
            workout
        end

        sig { params(workout_id: Integer).returns(T.nilable(WorkoutBuilderWorkout)) }
        def self.load_from_db(workout_id:)
            workout_record = Workout.find_by(id: workout_id)
            return nil unless workout_record

            # Assuming you have a way to retrieve exercises for this workout
            exercises = ExerciseHistory.where(workout_id: workout_id).map do |history_record|
                # You will need to implement logic to convert history_record to WorkoutBuilderExercise
            end

            # Initialize a new instance with the data from the workout_record
            workout_builder = new(user_id: workout_record.user_id)
            workout_builder.instance_variable_set(:@exercises, exercises)
            workout_builder.instance_variable_set(:@id, workout_record.id)
            workout_builder
        end

        private

        sig { params(id: String).returns(T.nilable(WorkoutBuilderExercise)) }
        def find_exercise(id:)
            @exercises.find { |exercise| exercise.id == id }
        end
    end 
end
