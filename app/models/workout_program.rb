# app/models/workout_program.rb
class WorkoutProgram < ApplicationRecord
    has_many :workouts, dependent: :destroy
end
  