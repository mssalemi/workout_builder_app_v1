module WorkoutProgramService
    class CreateTemplateWorkoutProgram
        class << self
            def generate_workout_program(user_id:, one_rep_max:)
                puts "Starting the generation of the workout program..."
                user = User.find_by(id: user_id)
                puts user
                
                if user.nil?
                    puts "No user found with ID: #{user_id}"
                    return
                end

                puts " are we getting here?"
                ActiveRecord::Base.transaction do
                    workout_program = WorkoutProgram.create!(
                        title: "Candito 6 Week Strength Program - 215 MAX - MATE",
                        user_id: user.id,
                        difficulty_level: "Intermediate",
                        duration_weeks: 5,
                    )

                    puts "WorkoutProgram created: #{workout_program.inspect}"

                    raise ActiveRecord::Rollback unless workout_program.persisted?

                    Rails.logger.debug "WorkoutProgram created: #{workout_program.inspect}"
                    raise "WorkoutProgram not saved!" unless workout_program.persisted?
                    
                    candito_workout_program = CanditoWorkoutProgram.workout_program_data(one_rep_max: one_rep_max)

                    puts "1"
                    puts "1"
                    puts "1"
                    puts "1"
                    puts "1"
                    puts "1"


                    candito_workout_program.each_with_index do |week_data, index|
                        puts "2222"
                        Rails.logger.debug "Creating week: #{index + 1}"
                        puts week_data
                        week = Week.create!(
                            workout_program_id: workout_program.id,
                            order: index + 1,
                        )
                        puts "33333"
                        fake_index = 1
                        week_data.each do |workout|

                            puts "44444"
                            puts "exercise"
                            puts workout[:exercises]
                            Rails.logger.debug "Creating workout: #{workout[:title]}"
                            create_workout(
                                user_id: user_id,
                                week_id: week.id,
                                order: fake_index,
                                exercises: workout[:exercises],
                                workout_title: workout[:title]
                            )
                            fake_index = fake_index + 1
                        end
                    end
                end
                    


            end                  

            private

            def create_workout(user_id:, week_id:, order:, exercises:, workout_title:)
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts exercises
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                puts "creating workouts with exercises:"
                workout = Workout.create!(
                    workout_week_id: week_id,
                    order: order,
                    title: workout_title,
                    user_id: user_id
                )
                puts "user_id =>", user_id
            
                if workout.persisted?
                    exercises.each do |exercise|
                        eh = ExerciseHistory.create(
                            user_id: user_id,
                            exercise_id: exercise[:exercise_id],
                            workout_id: workout.id,
                            performance_data: exercise[:performance_data],
                            order: exercise[:order]
                        )
                        unless eh.persisted?
                            puts "Failed to create ExerciseHistory: #{eh.errors.full_messages.join(', ')}"
                            return false  # Returning false if any exercise history fails
                        end
                    end
                    true
                else
                    puts "Failed to create Workout: #{workout.errors.full_messages.join(', ')}"
                    false
                end
            end
            
        end
    end
end