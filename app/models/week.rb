class Week < ApplicationRecord
  belongs_to :workout_program
  has_many :workouts, dependent: :destroy
end
