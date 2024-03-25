# typed: strict
class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :workout_program, optional: true
  has_many :exercise_histories, dependent: :destroy
end
