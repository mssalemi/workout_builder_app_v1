# typed: strict

module Mutations
    class CreateUserWorkout < BaseMutation
        extend T::Sig

        description "Creates a new workout session for a user. This includes setting up a title for the workout and associating it with a user."
    
        argument :title, String, required: false
        argument :workout_program_id, Integer, required: false
    
        type Types::WorkoutType
        
        sig { params(title: T.nilable(String), workout_program_id: T.nilable(Integer)).returns(Workout) }
        def resolve(title: nil, workout_program_id: nil)
            current_user = context[:current_user]
            int_user_id = current_user.id
            workout = WorkoutBuilder::WorkoutBuilderWorkout.create_user_workout(user_id: int_user_id, title: title, workout_program_id: workout_program_id)

            raise GraphQL::ExecutionError, "Failed to create workout" unless workout

            workout
        end
    end
end