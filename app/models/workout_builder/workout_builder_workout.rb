# typed: true

module WorkoutBuilder
    class WorkoutBuilderWorkout
        extend T::Sig

        GoalUpdate = T.type_alias { { workout_exercise_id: Integer, new_goal: WorkoutBuilderExercise::Goal } }
        Goal = T.type_alias { { weight: T.nilable(Integer), reps: T.nilable(Integer), sets: T.nilable(Integer), rpe: T.nilable(Integer) } }

        sig { returns(T::Array[WorkoutBuilderExercise]) }
        attr_reader :exercises

        sig { returns(User) }
        attr_reader :user

        sig { returns(Integer) }
        attr_reader :workout_id

        sig { returns(String) }
        attr_reader :title

        sig { params(workout_id: Integer, title: String, user_id: Integer, exercises: T::Array[WorkoutBuilderExercise]).void }
        def initialize(workout_id:, title:, user_id:, exercises: [])
            user = User.find_by(id: user_id)
            raise ActiveRecord::RecordNotFound if user.nil?

            @title = title
            @workout_id = workout_id
            @exercises = T.let(exercises, T::Array[WorkoutBuilderExercise])
            @user = user
        end

        sig { params(exercise_id: Integer, performance_data: Goal).returns(T::Array[WorkoutBuilderExercise]) }
        def add_exercise(exercise_id:, performance_data: {
            weight: 0,
            reps: 0,
            sets: 0,
            rpe: 0,
        })
            exercise = WorkoutBuilderExercise.create_workout_exercise(
                workout_id: @workout_id, 
                user_id: @user.id, 
                exercise_id: exercise_id, 
                performance_data: performance_data
            )
            
            @exercises << exercise if exercise

            exercises
        end

        sig { params(workout_id: T.untyped).returns(T.nilable(WorkoutBuilderWorkout)) }
        def self.load_from_db(workout_id:)
            workout_record = Workout.find_by(id: workout_id.to_i)
            return nil unless workout_record
        
            exercise_histories = ExerciseHistory.includes(:exercise).where(workout_id: workout_id)

            exercises = exercise_histories.map do |history_record|
                WorkoutBuilderExercise.new(
                    exercise_id: history_record.exercise_id,
                    exercise_history: history_record,
                    goal: history_record.performance_data.transform_keys(&:to_sym),
                    user_id: history_record.user_id,
                    completed: history_record.completed || false,
                    order: history_record.order || 0,
                )
            end

            # Initialize a new instance with the data from the workout_record
            workout_builder = new(
                workout_id: workout_id, 
                user_id: workout_record.user_id, 
                exercises: exercises, 
                title: workout_record.title || "No Title",
            )
            workout_builder
        end
        # x = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: 1)

        sig { params(reorder_instructions: T::Array[T::Hash[Symbol, Integer]]).void }
        def reorder_exercises(reorder_instructions)
            # Check for duplicate exercise_history_id entries
            history_ids = reorder_instructions.map { |instruction| instruction[:exercise_history_id] }
            if history_ids.uniq.length != history_ids.length
                raise ArgumentError, 'Duplicate exercise_history_id entries in reorder instructions'
            end

            reorder_instructions.each do |instruction|
                exercise_history_id = instruction[:exercise_history_id].to_i
                new_order = instruction[:new_order]
                
                # Find the exercise in the @exercises array
                exercise_to_reorder = @exercises.find do |exercise| 
                    exercise.exercise_history.id == exercise_history_id
                end

                next unless exercise_to_reorder

                # Update the order of the exercise
                exercise_to_reorder.edit_exercise(new_order: new_order)
            end

            # Optionally, sort @exercises by their new order
            @exercises.sort_by!(&:order)
        end

        sig { returns(T::Boolean) }
        def complete_workout
            begin
                @exercises.each do |exercise|
                    # Assuming default performance data is used for completion
                    exercise.complete_exercise
                end
                true
            rescue => e
                false
            end
        end

        sig { params(user_id: Integer, title: T.nilable(String)).returns(T.nilable(Workout)) }
        def self.create_user_workout(user_id:, title: nil)
            user = User.find_by(id: 1)
            return nil if user.nil?

            title = title || "Workout #{Time.now.to_i}"

            Workout.create!(user_id: user_id, title: title, goal: {})
        end

        sig { returns(Hash) }
        def graphql_data
            {
                id: self.workout_id,
                title: self.title,
                user_id: self.user.id,
                exercises: self.exercises.map { |exercise| exercise.graphql_data },
              }
        end
    end 
end
