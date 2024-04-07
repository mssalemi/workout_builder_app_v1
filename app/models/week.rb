class Week < ApplicationRecord
  belongs_to :workout_program
  has_many :workouts, -> { order(order: :asc) }, dependent: :destroy
end
