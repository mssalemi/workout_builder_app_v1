# Workout Builder App

## Overview

The Workout Builder App is a GraphQL API designed to manage workouts for users. It allows for the creation and modification of user workouts, including the addition of various exercises with performance metrics.

## Features

- **Manage Workouts**: Create and find workouts for users.
- **Exercise Tracking**: Add exercises to workouts with detailed performance data.

## GraphQL Schema - Example Queries

The API provides several queries and mutations to interact with workouts and exercises. Below is an example query to find a workout and its associated exercises:

```graphql

query GetExercise {
	exercises {
	  id        
    title
    bodyPartMain
    bodyPartAccessory
	}
}

mutation AddExerciseToWorkout {
  addExerciseToWorkout(input: {workoutId: 27, exerciseId: 1, performanceData: { reps:10, weight: 120, sets: 1 }}) {
    title
  }
}

mutation CreateWorkout {
  createUserWorkout(input: {userId: 1, title: "Cycle 3 - Week 1 - Bench Day 1"}) {
    id
  }
}

query FindWorkout {
  findWorkout(workoutId: 27) {
    title
    exercises {
      order
      completed
      performanceData {
        reps
        weight
        sets
        rpe
      }
      exerciseHistoryId
      exercise {
        title
        bodyPartMain
      }
    }
  }
}

mutation EditWorkout {
  updateExerciseInWorkout(input: {exerciseHistoryId: 288, newPerformanceData: {weight:230,reps:2, sets:1, rpe: 11}}) {
		order
    completed
    performanceData {
      weight
      reps
      sets
      rpe
    }
    
  }
}

mutation CompleteWorkout {
  completeWorkout(input: {workoutId: 26}) {
    id
  }
}

mutation Reorder {
  reorderExercisesInWorkout(input: {workoutId: 26, reorderInstructions:[{exerciseHistoryId: 288, newOrder:1},{newOrder: 0, exerciseHistoryId: 289}]}) {
    exercises {
            order
      completed
      exerciseHistoryId
      performanceData {
        reps
        weight
        sets
        
      }
    }
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
