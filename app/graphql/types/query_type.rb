# typed: false
# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Inside the module Types::QueryType
    field :user_friends, [Types::UserType], null: false, description: "Retrieve a list of friends for the current user."
    def user_friends
      current_user = context[:current_user]
      current_user.all_friends.uniq
    end


    field :exercises, [Types::ExerciseType], null: false,
      description: "An example field added by the generator"
    def exercises
      Exercise.all
    end

    field :find_workout, Types::WorkoutType, null: true do
      description "Find a workout by ID"
      argument :workout_id, Integer, required: true
    end
    
    def find_workout(workout_id:)
      workout = WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout_id)

      return nil unless workout  

      # current_user = context[:current_user]

      # if (workout.user.id != current_user.id)
      #   raise GraphQL::ExecutionError, "You are not authorized to view this workout."
      # end

      workout.graphql_data
    end

    field :find_workouts_by_user, [Types::WorkoutType], null: false do
      description "Find all workouts by User ID sent through JWT token."
    end

    def find_workouts_by_user
      current_user = context[:current_user]
      workouts = Workout.where(user_id: current_user.id).order(id: :desc).limit(10)
      workouts.map do |workout|
        WorkoutBuilder::WorkoutBuilderWorkout.load_from_db(workout_id: workout.id)
      end.map(&:graphql_data)
    end

    field :find_workout_program, Types::WorkoutProgramType, null: true do
      description "Find a workout program by ID"
      argument :program_id, GraphQL::Types::ID, required: true
    end
    
    def find_workout_program(program_id:)
      program = ::WorkoutProgram.find(program_id)
      # Authorization checks here
      program
    end

    field :find_workout_programs_by_user, [Types::WorkoutProgramType], null: false do
      description "Find all workout programs by User ID sent through JWT token."
    end
    
    def find_workout_programs_by_user
      current_user = context[:current_user]
      puts "current_user: #{current_user.inspect}"
      programs = WorkoutProgram.where(user_id: current_user.id).order(id: :desc).limit(10)
      programs
    end

    field :find_friends_workout_programs, [Types::WorkoutProgramType], null: false do
      description "Find all workout programs by User ID sent through JWT token."
    end
    def find_friends_workout_programs
      current_user = context[:current_user]
      friends = current_user.all_friends
      friend_workouts = []
      friends.each do |friend|
        friend_workouts << WorkoutProgram.where(user_id: friend.id).order(id: :desc).limit(10)
      end
      friend_workouts.flatten.uniq
    end
  end
end
