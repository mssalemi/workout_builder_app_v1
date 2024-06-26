# app/models/workout_program.rb
class WorkoutProgram < ApplicationRecord
    has_many :weeks, -> { order(order: :asc) }, dependent: :destroy
    # Through relationship to access workouts indirectly through weeks
    has_many :workouts, through: :weeks
end
  