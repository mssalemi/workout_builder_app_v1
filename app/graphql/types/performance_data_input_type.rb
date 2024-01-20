module Types
    class PerformanceDataInputType < Types::BaseInputObject
      description "Performance data for an exercise"
      argument :weight, Integer, required: false
      argument :reps, Integer, required: false
      argument :sets, Integer, required: false
      argument :rpe, Integer, required: false
    end
end