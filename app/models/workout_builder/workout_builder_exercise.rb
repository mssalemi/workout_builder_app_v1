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

        sig { returns(Integer) }
        attr_reader :workout_id, :user_id

        #  WorkoutBuilder::WorkoutBuilderExercise.new(excercise_id: 1, exercise_history: ExerciseHistory.first, completed: false, goal: {weight: 100, reps: 10, sets: 3})

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
            @user_id = user_id
        end

        sig { params(new_performance_data: T.nilable(Goal)).void }
        def complete_exercise(new_performance_data: nil)
            performance_data = new_performance_data || {
                weight: @goal[:weight],
                reps: @goal[:reps],
                sets: @goal[:sets],
            }

            exercise = @exercise_history.update!(
                performance_data: performance_data,
                completed: true,
            )

            # @exercise_history.update!(performance_data: performance_data,completed: true)

            @completed = true if exercise

            exercise
        end

        sig { params(exercise_history_id: Integer).returns(T.nilable(WorkoutBuilder::WorkoutBuilderExercise))}
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

        sig { params(workout_id: Integer, user_id: Integer, exercise_id: Integer, performance_data: Goal).returns(WorkoutBuilderExercise) }
        def self.create_workout_exercise(workout_id:, user_id:, exercise_id:, performance_data:)
            exercise_history = ExerciseHistory.create!(
                exercise_id: exercise_id,
                workout_id: workout_id,
                user_id: user_id,
                performance_data: performance_data,
                completed: false,
            )

            raise ActiveRecord::RecordInvalid unless exercise_history.valid?

            new(
                exercise_id: exercise_id,
                exercise_history: exercise_history,
                goal: performance_data,
                user_id: user_id,
                completed: false,
            )
        end
    end 
end
