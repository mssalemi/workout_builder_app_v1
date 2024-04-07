# app/graphql/types/week_type.rb

module Types
    class WeekType < Types::BaseObject
      field :id, Integer, null: false
      field :workout_program_id, Integer, null: false
      field :order, Integer, null: true, description: "The order of the week within its workout program"
      field :created_at, GraphQL::Types::ISO8601DateTime, null: false
      field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  
      # Define a field to get the workouts associated with this week
      field :workouts, [Types::WorkoutType], null: false, description: "List of workouts in this week"
  
      # Define a method to resolve the workouts field
      def workouts
        # Assuming a Week `has_many :workouts` association
        object.workouts.order(:order).map do |workout|
            WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout.id).graphql_data
        end
      end
    end
end
  