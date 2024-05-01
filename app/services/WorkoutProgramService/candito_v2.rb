module WorkoutProgramService
    class CanditoV2
        DIFFICULTY_LEVEL = "Intermediate"
        DURATION_WEEKS = 5

        def initialize(one_rep_max:, user_id:)
            @one_rep_max = one_rep_max
            @user = User.find(user_id)
            @title = "Candito6W - 1rm #{@one_rep_max} #{@user.name}"
            @desc = "Candito 6 Week Strength Program. This program is designed to help you increase your strength over 6 weeks."

            @workout_program = create_workout_program

            create_weeks
        end

        def create_workout_program
            puts "user??"
            puts @user.inspect
            puts "?"
            WorkoutProgram.create!(
                title: @title,
                description: @desc,
                user_id: @user.id,
                difficulty_level: DIFFICULTY_LEVEL,
                duration_weeks: DURATION_WEEKS,
            )
        end

        def create_weeks
            create_week(week_num: 1, week_daily_exercises: week_1_exercises)
            create_week(week_num: 2, week_daily_exercises: week_2_exercises)
            create_week(week_num: 3, week_daily_exercises: week_3_exercises)
            create_week(week_num: 4, week_daily_exercises: week_4_exercises)
            create_week(week_num: 5, week_daily_exercises: week_5_exercises)
        end

        private

        def create_week(week_num:, week_daily_exercises:)

            puts "Week #{week_num}"
            puts week_1_exercises.inspect
            week = Week.create!(
                workout_program_id: @workout_program.id,
                order: week_num,
            )

            week_daily_exercises.each_with_index do |daily_workout, index|
                puts "daily_workout", daily_workout
                week_id = week.id
                order = index + 1
                title = daily_workout[:title]
                workout_exercises = daily_workout[:exercises]
                
                workout = Workout.create!(
                    user_id: @workout_program.user_id,
                    workout_week_id: week_id,
                    order: order,
                    title: title,
                )

                workout_exercises.each do |daily_exercise|
                        eh = ExerciseHistory.create!(
                            workout_id: workout.id,
                            exercise_id: daily_exercise[:exercise_id],
                            user_id: @workout_program.user_id,
                            performance_data: {
                                reps: daily_exercise[:reps],
                                sets: daily_exercise[:sets],
                                weight: daily_exercise[:weight],
                            },
                        )
                        eh
                end
            end
        end

        def week_1_exercises
            day_1 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10, 
                    sets: 1, 
                    percentage_1rm: 0.5, 
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10,
                    sets: 1,
                    percentage_1rm: 0.675,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 8,
                    sets: 1,
                    percentage_1rm: 0.75,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 6,
                    sets: 1,
                    percentage_1rm: 0.775,
                ).to_hash,
            ]
            day_2 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10,
                    sets: 1,
                    percentage_1rm: 0.5,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10,
                    sets: 1,
                    percentage_1rm: 0.675,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 8,
                    sets: 1,
                    percentage_1rm: 0.75,
                ).to_hash,
            ]
            day_3 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 15,
                    sets: 1,
                    percentage_1rm: 0.8,
                ).to_hash
            ]
            [
                {
                    title: "The Beginning, Reps, Reps, Reps",
                    exercises: day_1
                },
                {
                    title: "Sweat Equity",
                    exercises: day_2
                },
                {
                    title: "ARMRAP - Coffee Edition",
                    exercises: day_3
                }
            ]
        end

        def week_2_exercises
            day_1 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10, 
                    sets: 1, 
                    percentage_1rm: 0.725, 
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 8,
                    sets: 1,
                    percentage_1rm: 0.775,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 6,
                    sets: 1,
                    percentage_1rm: 0.8,
                ).to_hash,
            ]
            day_2 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10, 
                    sets: 1, 
                    percentage_1rm: 0.725, 
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 8,
                    sets: 1,
                    percentage_1rm: 0.775,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 6,
                    sets: 1,
                    percentage_1rm: 0.8,
                ).to_hash,
            ]
            day_3 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 15,
                    sets: 1,
                    percentage_1rm: 0.8,
                    weight_modifier: -5,
                ).to_hash
            ]
            [
                {
                    title: "Chest Extreme Pump Day",
                    exercises: day_1
                },
                {
                    title: "Pecs Perfection",
                    exercises: day_2
                },
                {
                    title: "Paralyze em with Pecs",
                    exercises: day_3
                }
            ]
        end

        def week_3_exercises
            day_1 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 6, 
                    sets: 3, 
                    percentage_1rm: 0.85, 
                ).to_hash,
            ]
            day_2 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 10, 
                    sets: 1, 
                    percentage_1rm: 0.85,
                    weight_modifier: 5, 
                ).to_hash,
            ]
            [
                {
                    title: "Heavy Weight Acclimation",
                    exercises: day_1
                },
                {
                    title: "Get it did...",
                    exercises: day_2
                },
            ]
        end

        def week_4_exercises
            day_1 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 3, 
                    sets: 1, 
                    percentage_1rm: 0.85,
                    round_type: "down", 
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 3, 
                    sets: 1, 
                    percentage_1rm: 0.9,
                    round_type: "down",
                    weight_modifier: -5,

                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 3, 
                    sets: 1, 
                    percentage_1rm: 0.9,
                    round_type: "up", 
                ).to_hash,
            ]
            day_2 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 3, 
                    sets: 1, 
                    percentage_1rm: 0.875,
                    round_type: "down",
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 4, 
                    sets: 1, 
                    percentage_1rm: 0.9,
                ).to_hash,
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 2, 
                    sets: 1, 
                    percentage_1rm: 0.95,
                    round_type: "down", 
                ).to_hash,
            ]
            [
                {
                    title: "Failing to prepare is preparing to fail",
                    exercises: day_1
                },
                {
                    title: "The Peak",
                    exercises: day_2
                },
            ]
        end

        def week_5_exercises
            day_1 = [
                WorkoutExercise.new(
                    one_rep_max: @one_rep_max,
                    reps: 2, 
                    sets: 1, 
                    percentage_1rm: 0.975,
                ).to_hash,
            ]
            [
                {
                    title: "The END",
                    exercises: day_1
                },
            ]
        end

        class WorkoutExercise            
            def initialize(one_rep_max:, reps:, sets:, percentage_1rm:, round_type: nil, weight_modifier: nil)
                @reps = reps
                @sets = sets
                @percentage_1rm = percentage_1rm
                @weight_modifier = weight_modifier
                @round_type = round_type
                @one_rep_max = one_rep_max
            end

            def calculate_weight
                return 0 if @percentage_1rm.nil? 

                ## rount type can be up or down, this should round the the nearest 5
                weight = @percentage_1rm * @one_rep_max
                if @round_type == "up"
                    weight = (weight / 5.0).ceil * 5
                elsif @round_type == "down"
                    weight = (weight / 5.0).floor * 5
                else
                    weight = (weight / 5.0).round * 5
                end

                if @weight_modifier
                    weight += @weight_modifier
                end

                weight
            end

            def to_hash
                {
                    reps: @reps,
                    sets: @sets,
                    weight: calculate_weight,
                    exercise_id: 1
                }
            end
        end
    end
end