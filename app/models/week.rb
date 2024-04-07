class Week < ApplicationRecord
  belongs_to :workout_program
  has_many :workouts, -> { order(order: :asc) }, foreign_key: 'workout_week_id', dependent: :destroy
end
