# typed: strict

module WorkoutBuilder
    class WorkoutBuilderExercise
        extend T::Sig

        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer) } }

        sig { returns(Integer) }
        attr_reader :exercise_id

        sig { returns(Goal) }
        attr_reader :goal

        sig { returns(T::Boolean) }
        attr_reader :complete

        sig { returns(String) }
        attr_reader :id


        sig { params(exercise_id: Integer, goal: Goal).void }
        def initialize(exercise_id:, goal:)
            @exercise_id = exercise_id
            @goal = goal
            @complete = T.let(false, T::Boolean)
            @id = T.let(SecureRandom.uuid, String)
        end

        sig { returns(T.nilable(Exercise)) }
        def exercise
            Exercise.find(@exercise_id)
        end

        sig { params(new_goal: Goal).void }
        def update_goal(new_goal)
            @goal = @goal.merge(new_goal)
        end

        sig { params(workout_id: Integer, user_id: Integer).void }
        def complete_exercise(workout_id:, user_id:)
            performance_data = {
                weight: @goal[:weight],
                reps: @goal[:reps],
                sets: @goal[:sets],
            }

            exercise = ExerciseHistory.create(
                workout_id: workout_id,
                user_id: user_id,
                exercise_id: @exercise_id,
                performance_data: performance_data,
            )

            @complete = true if exercise.persisted?

            exercise
        end

    end 
end
