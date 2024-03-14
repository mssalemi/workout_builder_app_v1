# typed: strict

module Mutations
    class CreateUserWorkout < BaseMutation
        extend T::Sig

        description "Creates a new workout session for a user. This includes setting up a title for the workout and associating it with a user."
    
        argument :user_id, Integer, required: true
        argument :title, String, required: false
    
        type Types::WorkoutType
        
        sig { params(user_id: Integer, title: T.nilable(String)).returns(Workout) }
        def resolve(user_id:, title: nil)
            int_user_id = user_id.to_i
            workout = WorkoutBuilder::WorkoutBuilderWorkout.create_user_workout(user_id: int_user_id, title: title)

            raise GraphQL::ExecutionError, "Failed to create workout" unless workout

            workout
        end
    end
end