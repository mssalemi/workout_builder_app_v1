# app/graphql/types/workout_program_type.rb

module Types
    class WorkoutProgramType < Types::BaseObject
      field :id, Integer, null: false
      field :title, String, null: false
      field :description, String, null: true
      field :user_id, Integer, null: false
      field :difficulty_level, String, null: true
      field :duration_weeks, Integer, null: true
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  
      field :workouts, [Types::WorkoutType], null: false, description: "List of workouts in this workout program"
  
      def workouts
        # Assuming a WorkoutProgram `has_many :workouts` association
        object.workouts
        []
      end
    end
  end
  