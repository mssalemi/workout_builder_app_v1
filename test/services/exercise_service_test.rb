# typed: false
require 'test_helper'

class ExerciseServiceTest < ActiveSupport::TestCase
  test "filter exercises by title" do
    exercises = ExerciseService.filter_exercises(title: "Bench Press")
    assert exercises.any?
    assert_equal "Bench Press", exercises.first.title
  end

  test "filter exercises by category" do
    exercises = ExerciseService.filter_exercises(category: "upper")
    assert exercises.any?
    exercises.each do |exercise|
      assert_equal "upper", exercise.category
    end
  end

  test "filter exercises by main body part" do
    exercises = ExerciseService.filter_exercises(body_part_main: "Chest")
    assert exercises.any?
    exercises.each do |exercise|
      assert_equal "Chest", exercise.body_part_main
    end
  end

  test "filter exercises by accessory body part" do
    exercises = ExerciseService.filter_exercises(body_part_accessory: "Triceps")
    assert exercises.any?


    exercises.each do |exercise|
      assert_includes exercise.body_part_accessory['body_parts'], "Triceps"
    end
  end
end
