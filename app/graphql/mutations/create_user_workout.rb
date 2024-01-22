# typed: true

module Mutations
    class CreateUserWorkout < BaseMutation
        extend T::Sig

        description "Creates a new workout session for a user. This includes setting up a title for the workout and associating it with a user."
    
        argument :user_id, Integer, required: true
        argument :title, String, required: false
    
        type Types::WorkoutType
        
        sig { params(user_id: Integer, title: T.nilable(String)).returns(T::Hash[T.untyped, T.untyped]) }
        def resolve(user_id:, title: nil)
            int_user_id = user_id.to_i
            WorkoutBuilder::WorkoutBuilderWorkout.create_user_workout(user_id: int_user_id, title: title)
        end
    end
end