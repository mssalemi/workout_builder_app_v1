# typed: true

module WorkoutBuilder
    class WorkoutBuilderExercise
        extend T::Sig

        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer), rpe: T.nilable(Integer) } }

        sig { returns(Integer) }
        attr_reader :exercise_id, :workout_id, :user_id, :order

        sig { returns(Goal) }
        attr_reader :goal

        sig { returns(T::Boolean) }
        attr_reader :completed

        sig { returns(ExerciseHistory) }
        attr_reader :exercise_history

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
                rpe: @goal[:rpe],
            }

            exercise = @exercise_history.update!(
                performance_data: performance_data,
                completed: true,
            )

            # @exercise_history.update!(performance_data: performance_data,completed: true)

            @completed = true if exercise

            exercise
        end

        sig { params(new_order: T.nilable(Integer), new_performance_data: T.nilable(Goal)).void }
        def edit_exercise(new_order: nil, new_performance_data: nil)
            # Update the order if a new order is provided
            if new_order
                @order = new_order
                # Update the corresponding field in the exercise history record
                @exercise_history.update!(order: new_order)
            end

            # Update the performance data if new performance data is provided
            if new_performance_data
                @goal = new_performance_data
                # Update the corresponding field in the exercise history record
                @exercise_history.update!(performance_data: new_performance_data)
            end
        end

        sig { params(exercise_id: Integer, new_order: Integer).returns(T.nilable(WorkoutBuilderExercise)) }
        def reorder_exercise(exercise_id:, new_order:)
            raise ArgumentError, 'Invalid order' if new_order < 0

            exercise_to_reorder = @exercises.find { |exercise| exercise.exercise_id == exercise_id }
            return nil unless exercise_to_reorder

            # Updating the order of the exercise
            exercise_to_reorder.edit_exercise(new_order: new_order)

            # Optionally, reorder the other exercises to maintain a consistent ordering
            # This step depends on how you want to manage the ordering logic

            exercise_to_reorder
        end

        sig { params(exercise_history_id: Integer).returns(T.nilable(WorkoutBuilder::WorkoutBuilderExercise))}
        def self.load_from_db(exercise_history_id:)
            exercise_history = ExerciseHistory.includes(:exercise).find_by(id: exercise_history_id)
            return nil if exercise_history.nil?

            goal = {
                weight: exercise_history.performance_data["weight"],
                reps: exercise_history.performance_data["reps"],
                sets: exercise_history.performance_data["sets"],
                rpe: exercise_history.performance_data["rpe"],
            }

            new(
                exercise_id: exercise_history.exercise_id,
                exercise_history: exercise_history,
                goal: goal,
                user_id: exercise_history.user_id,
                completed: exercise_history.completed || false,
                order: 0,
            )
        end

        sig { params(workout_id: Integer, user_id: Integer, exercise_id: Integer, performance_data: Goal).returns(WorkoutBuilderExercise) }
        def self.create_workout_exercise(workout_id:, user_id:, exercise_id:, performance_data:)
            
            existing = ExerciseHistory.where(workout_id: workout_id)
            order = existing.count + 1
            
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
                order: exercise_history.order || 0,
            )
        end

        sig { returns(Hash) }
        def graphql_data
            {
                completed: self.completed,
                performance_data: self.goal,
                order: self.order,
                exercise_history_id: self.exercise_history.id,
                exercise_id: self.exercise_id,
                user_id: self.user_id,
            }
        end

    end 
end
