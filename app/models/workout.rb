# typed: strict
class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :week 
  has_many :exercise_histories, dependent: :destroy
end
