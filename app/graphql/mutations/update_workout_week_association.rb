# typed: strict

module Mutations
    class UpdateWorkoutWeekAssociation < BaseMutation
      extend T::Sig
  
      argument :id, Integer, required: true
      ## This naming is a bit conusing, but this assossication represents:
      ## A workout belongs to a week, and a week belongs to a workout program.
      argument :workout_week_id, Integer, required: false
      argument :order, Integer, required: false
  
      type Types::WeekType
  
      sig { params(id: Integer, workout_week_id: Integer, order: Integer).returns(T.untyped) }
      def resolve(id:, workout_week_id:, order:)
        workout = Workout.find(id)
        workout.update!(workout_week_id: workout_week_id, order: order) if workout.present?
        workout.week
      end
    end
end
  