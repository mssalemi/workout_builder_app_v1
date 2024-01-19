module Types
    class ReorderInstructionInputType < Types::BaseInputObject
      description "Input type for exercise reorder instructions"
  
      argument :exercise_history_id, ID, required: true, description: "The ID of the exercise history record"
      argument :new_order, Integer, required: true, description: "The new order for the exercise"
    end
end
  