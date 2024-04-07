# typed: strict
class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :week, foreign_key: 'workout_week_id', optional: true
  has_many :exercise_histories, dependent: :destroy
end
