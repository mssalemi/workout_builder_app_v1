module Types
    class PerformanceDataType < Types::BaseObject
      description "Performance data for an exercise"
      field :weight, Integer, null: true
      field :reps, Integer, null: true
      field :sets, Integer, null: true
    end
end