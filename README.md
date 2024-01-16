# Workout Builder App

## Overview

The Workout Builder App is a GraphQL API designed to manage workouts for users. It allows for the creation and modification of user workouts, including the addition of various exercises with performance metrics.

## Features

- **Manage Workouts**: Create and find workouts for users.
- **Exercise Tracking**: Add exercises to workouts with detailed performance data.

## GraphQL Schema

The API provides several queries and mutations to interact with workouts and exercises. Below is an example query to find a workout and its associated exercises:

```graphql
query FindWorkout {
  findWorkout(workoutId: 1) {
    title
    exercises {
      completed
      performanceData {
        reps
        weight
        sets
      }
      exercise {
        title
        bodyPartMain
      }
    }
  }
}

mutation AddExerciseToWorkout {
  addExerciseToWorkout(workoutId: 4, exerciseId: 1, performanceData: { reps:2, weight: 235, sets: 1 }) {
      title
    }
  }
```

```graphql
query GetExercise {
    exercises {
      title
      description
    }
  }
```

## Models
The application uses the following primary models:

User: Represents a user of the app.
Workout: Contains details about a user's workout.
Exercise: Represents an exercise included in a workout.
ExerciseHistory: Tracks the performance data of exercises in workouts.
Each model is backed by an ActiveRecord schema and is tightly integrated into the GraphQL API.

Dev Notes
This application is currently in the development phase. Features and schema are subject to change.

My Dev Commands

```ruby
bin/tapioca dsl
srb typecheck
bundle exec srb rbi update
```
