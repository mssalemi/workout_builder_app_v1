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

    # Field for the weeks associated with this workout program
    field :weeks, [Types::WeekType], null: false, description: "List of weeks in this workout program"
  end
end
