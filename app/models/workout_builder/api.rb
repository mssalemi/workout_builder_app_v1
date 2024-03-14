# typed: strict

module WorkoutBuilder
    class Api
        extend T::Sig

        ## Create Workout
        ### Saves emptry workout to database
        # def create_workout(user_id:)
        #     workout = WorkoutBuilderWorkout.new(user_id: user_id)
        #     workout.save
        # end

        # def add_exercise_to_workout(workout_id:, exercise_id:, goal:)
        #     workout = find_workout(workout_id: workout_id)
        #     workout.add_exercise(exercise_id: exercise_id, goal: goal)
        # end

        ## Update Workout
        ### Add Exercise to Workout
        ##### Adds Exercise to Exercise history

        ### Remove Exercise from Workout
        ##### Removes Exercise from Exercise history

        ### Update Exercise(s) Goal
        ##### Updates Workout Exercise Goal

        ## Complete Workout
        # private

        sig { params(workout_id: Integer).returns(WorkoutBuilderWorkout) }
        def find_workout(workout_id:)
            WorkoutBuilderWorkout.load_from_db(workout_id: workout_id) || raise(ActiveRecord::RecordNotFound)
        end
    end
end