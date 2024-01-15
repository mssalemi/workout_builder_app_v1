# typed: true

module WorkoutBuilder
    class WorkoutBuilderExercise
        extend T::Sig

        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer) } }

        sig { returns(Integer) }
        attr_reader :exercise_id

        sig { returns(Goal) }
        attr_reader :goal

        sig { returns(T::Boolean) }
        attr_reader :completed

        sig { returns(String) }
        attr_reader :id


        sig { params(
            exercise_id: Integer, 
            exercise_history: ExerciseHistory, 
            completed: T::Boolean,
            goal: Goal, 
            user_id: Integer
            ).void 
        }
        def initialize(exercise_id:, exercise_history:, completed:, goal: {
            weight: nil,
            reps: nil,
            sets: nil,
        }, user_id: 1)
            @exercise_id = exercise_id
            @exercise_history = exercise_history
            @goal = goal
            @completed = completed
            @id = T.let(SecureRandom.uuid, String)
            @user_id = user_id
        end

        sig {void }
        def complete_exercise
            performance_data = {
                weight: @goal[:weight],
                reps: @goal[:reps],
                sets: @goal[:sets],
            }

            puts performance_data

            debugger

            exercise = @exercise_history.update!(
                performance_data: performance_data,
                completed: true,
            )

            # @exercise_history.update!(performance_data: performance_data,completed: true)

            @completed = true if exercise

            exercise
        end

        def self.load_from_db(exercise_history_id:)
            exercise_history = ExerciseHistory.includes(:exercise).find_by(id: exercise_history_id)
            return nil if exercise_history.nil?

            goal = {
                weight: exercise_history.performance_data["weight"],
                reps: exercise_history.performance_data["reps"],
                sets: exercise_history.performance_data["sets"],
            }

            new(
                exercise_id: exercise_history.exercise_id,
                exercise_history: exercise_history,
                goal: goal,
                user_id: exercise_history.user_id,
                completed: exercise_history.completed || false,
            )
        end

    end 
end
