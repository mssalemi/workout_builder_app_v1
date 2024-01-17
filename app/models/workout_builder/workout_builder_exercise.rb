# typed: true

module WorkoutBuilder
    class WorkoutBuilderExercise
        extend T::Sig

        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer) } }

        sig { returns(Integer) }
        attr_reader :exercise_id, :workout_id, :user_id, :order

        sig { returns(Goal) }
        attr_reader :goal

        sig { returns(T::Boolean) }
        attr_reader :completed

        #  WorkoutBuilder::WorkoutBuilderExercise.new(excercise_id: 1, exercise_history: ExerciseHistory.first, completed: false, goal: {weight: 100, reps: 10, sets: 3})

        sig { params(
            exercise_id: Integer, 
            exercise_history: ExerciseHistory, 
            completed: T::Boolean,
            goal: Goal, 
            user_id: Integer,
            order: Integer
            ).void 
        }
        def initialize(exercise_id:, exercise_history:, completed:, goal:, user_id:, order:)
            @exercise_id = exercise_id
            @exercise_history = exercise_history
            @completed = completed
            @goal = goal
            @user_id = user_id
            @order = order
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
                order: exercise_history.order,
            )
        end

        sig { params(workout_id: Integer, user_id: Integer, exercise_id: Integer, performance_data: Goal).returns(WorkoutBuilderExercise) }
        def self.create_workout_exercise(workout_id:, user_id:, exercise_id:, performance_data:)
            
            order = ExerciseHistory.where(workout_id: workout_id).count
            
            exercise_history = ExerciseHistory.create!(
                exercise_id: exercise_id,
                workout_id: workout_id,
                user_id: user_id,
                performance_data: performance_data,
                completed: false,
                order: order,
            )

            raise ActiveRecord::RecordInvalid unless exercise_history.valid?

            new(
                exercise_id: exercise_id,
                exercise_history: exercise_history,
                goal: performance_data,
                user_id: user_id,
                completed: false,
                order: exercise_history.order,
            )
        end
    end 
end
