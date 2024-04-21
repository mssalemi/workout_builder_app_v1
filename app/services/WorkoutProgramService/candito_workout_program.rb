module WorkoutProgramService
    class CanditoWorkoutProgram
        class << self
            def workout_program_data(one_rep_max:)
                day_1_exercises = [
                    [1,10,0.5],
                    [1,10,0.675],
                    [1,10,0.75],
                    [1,10,0.775],
                ]

                day_2_exercises = [
                    [1,10,0.5],
                    [1,10,0.675],
                    [1,10,0.75],
                    [1,10,0.775],
                ]

                day_3_exercises = [
                    [1,15,0.8],
                ]

                week_1 = [
                    {
                        title: "Week 1 - Day 1 - Upper",
                        exercises: day_1_exercises
                    },
                    {
                        title: "Week 1 - Day 2 - Upper",
                        exercises: day_2_exercises
                    },
                    {
                        title: "Week 1 - Day 3 - Upper",
                        exercises: day_3_exercises
                    }
                ]

                week_2_day_1_exercises = [
                    [1,10,0.725],
                    [1,8,0.775],
                    [1,7,0.8],
                ]

                week_2_day_2_exercises = [
                    [1,10,0.725],
                    [1,8,0.775],
                    [1,7,0.8],
                ]

                week_2_day_3_exercises = [
                    [1,15,0.8],
                ]
                week_2 = [
                    {
                    title: "Week 2 - Day 1 - Upper",
                    exercises: week_2_day_1_exercises
                    },
                    {
                    title: "Week 2 - Day 2 - Upper",
                    exercises: week_2_day_2_exercises
                    },
                    {
                    title: "Week 2 - Day 3 - Upper",
                    exercises: week_2_day_3_exercises
                    }
                ]

                week_3_day_1 = [
                    [3,6,0.85],
                ]

                week_3_day_2 = [
                    [3,6,0.87],
                ]

                week_3 = [
                    {
                    title: "Week 3 - Day 1 - Upper",
                    exercises: week_3_day_1
                    },
                    {
                    title: "Week 3 - Day 2 - Upper",
                    exercises: week_3_day_2
                    },
                ]

                # week 4 day 1 - 1 set 85% 3 reps, 1 set 875% 3 reps, 1 set 90% 3 rep
                week_4_day_1 = [
                    [1,3,0.85],
                    [1,3,0.875],
                    [1,3,0.9],
                ]
                week_4_day_2 = [
                    [1,2,0.875],
                    [1,4,0.9],
                    [1,2,0.925],
                ]
                week_4 = [
                    {
                    title: "Week 4 - Day 1 - Upper",
                    exercises: week_4_day_1
                    },
                    {
                    title: "Week 4 - Day 2 - Upper",
                    exercises: week_4_day_2
                    },
                ]

                week_5_day_1 = [
                    [1,2,0.975]
                ]
                week_5 = [
                    {
                    title: "Week 5 - Day 1 - Upper",
                    exercises: week_5_day_1
                    }
                ]


                [
                    week_workout_data(one_rep_max: one_rep_max, days: week_1),
                    week_workout_data(one_rep_max: one_rep_max, days: week_2),
                    week_workout_data(one_rep_max: one_rep_max, days: week_3),
                    week_workout_data(one_rep_max: one_rep_max, days: week_4),
                    week_workout_data(one_rep_max: one_rep_max, days: week_5),
                ] 
            end

            def week_workout_data(one_rep_max:, days:)

                weekly_workout = days.map do |day|
                    generate_workout_data(one_rep_max: one_rep_max, title: day[:title], exercise_data_truple_array: day[:exercises])
                end

                # day_1_exercises = [
                #   [1,10,0.5],
                #   [1,10,0.675],
                #   [1,10,0.75],
                #   [1,10,0.775],
                # ]

                # day_2_exercises = [
                #   [1,10,0.5],
                #   [1,10,0.675],
                #   [1,10,0.75],
                #   [1,10,0.775],
                # ]

                # day_3_exercises = [
                #   [1,15,0.8],
                # ]

                # [
                #   generate_workout_data(one_rep_max: one_rep_max, title: "Week 1 - Day 1 - Upper", exercise_data_truple_array: day_1_exercises),
                #   generate_workout_data(one_rep_max: one_rep_max, title: "Week 1 - Day 2 - Upper", exercise_data_truple_array: day_2_exercises),
                #   generate_workout_data(one_rep_max: one_rep_max, title: "Week 1 - Day 3 - Upper", exercise_data_truple_array: day_3_exercises),
                # ]
                weekly_workout
            end

            def generate_workout_data(one_rep_max:, title:, exercise_data_truple_array:)
                # This 'truple' is [sets, reps, percentage_1rm]
                exercises = exercise_data_truple_array.map do |exercise_data_truple|
                    generate_exercise(one_rep_max: one_rep_max, exercise_id: 1, sets: exercise_data_truple[0], reps: exercise_data_truple[1], percentage_1rm: exercise_data_truple[2])
                end

                { 
                    workoutTitle: title, 
                    exercises: exercises
                }
            end

            def generate_exercise(one_rep_max:, exercise_id:, sets:, reps:, percentage_1rm:)
                {
                    exercise_id: exercise_id, 
                    performance_data: {
                        sets: sets,
                        reps: reps,
                        weight: (one_rep_max * percentage_1rm).to_i  # Converting to integer
                    }
                }
            end
        end
    end
end