# app/graphql/mutations/create_workout_program.rb

module Mutations
    class CreateWorkoutProgram < BaseMutation
      argument :title, String, required: true
      argument :description, String, required: false
      argument :difficulty_level, String, required: false
      argument :duration_weeks, Integer, required: false
  
      type Types::WorkoutProgramType
  
      def resolve(title:, description: nil, difficulty_level: nil, duration_weeks: nil)
        user = context[:current_user]
        raise GraphQL::ExecutionError, "You need to authenticate to perform this action" unless user
  
        workout_program = WorkoutProgram.new(
          title: title,
          description: description,
          difficulty_level: difficulty_level,
          duration_weeks: duration_weeks,
          user_id: user.id
        )
  
        if workout_program.save
          workout_program
        else
          raise GraphQL::ExecutionError, workout_program.errors.full_messages.join(", ")
        end
      end
    end
end
  