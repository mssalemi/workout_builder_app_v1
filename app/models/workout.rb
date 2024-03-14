# typed: strict
class Workout < ApplicationRecord
  belongs_to :user
  has_many :exercise_histories, dependent: :destroy
end
