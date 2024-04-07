# typed: strict

module Mutations
    class CreateUserWorkout < BaseMutation
      extend T::Sig
  
      description "Creates a new workout session for a user, optionally associating it with a specific week."
  
      argument :title, String, required: false
      argument :workout_week_id, Integer, required: false, description: "ID of the week to associate this workout with, inherently linking it to the workout program of that week."
      argument :order, Integer, required: false, description: "Order of the workout within its week."
  
      type Types::WorkoutType
      
      sig { params(title: T.nilable(String), workout_week_id: T.nilable(Integer), order: T.nilable(Integer)).returns(T.untyped) }
      def resolve(title: nil, workout_week_id: nil, order: nil)
        current_user = context[:current_user]
        int_user_id = current_user.id
        
        # Ensure the workout_week_id is provided and valid
        week = T.unsafe(Week).find_by(id: workout_week_id)
        raise GraphQL::ExecutionError, "Week not found" unless week
  
        # Create the workout associated with the week
        workout = Workout.new(
          user_id: int_user_id, 
          title: title, 
          week_id: week.id, 
          order: order
        )
  
        raise GraphQL::ExecutionError, "Failed to create workout" unless workout.save
  
        workout
      end
    end
end
  