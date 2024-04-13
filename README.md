# Workout Builder App

## Overview

The Workout Builder App is a GraphQL API designed to manage workouts for users. It allows for the creation and modification of user workouts, including the addition of various exercises with performance metrics.

## Features

- **Manage Workouts**: Create and find workouts for users.
- **Exercise Tracking**: Add exercises to workouts with detailed performance data.

## GraphQL Schema - Example Queries

The API provides several queries and mutations to interact with workouts and exercises. Below is an example query to find a workout and its associated exercises:

HEADERS:

```graphql

{
  "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE3MTI2ODMxNTd9phjb4VM-3ILNkWJLHiOnfzhiKsi0KZar06hTiz4vfGU",
  "Content-Type": "application/json"
}

```

Find Workout Programs

```graphql

query FindWorkoutProgramsByUser {
  findWorkoutProgramsByUser {
    id
    userId
    title
    description
    difficultyLevel
    weeks {
      workoutProgramId
      order
      workouts {
        title
        exercises {
          performanceData {
            reps
            weight
            sets
          }
          exercise {
            title
          }
          userId
        }
        
      }
    }
  }
}

```

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

### I asked Chat GPT, how to add user auth, and some suggestions for improvements:
Adding user authentication/authorization and expanding the API with new features while keeping the existing structure intact is a great way to improve your workout app. Let's break down the improvements into two parts: implementing user authentication/authorization and suggesting new queries/mutations.

Implementing User Authentication/Authorization
For user authentication and authorization, using JWT (JSON Web Tokens) is a common and effective approach. You can integrate JWT without major disruptions to your current API design. Here's a simplified outline of how you can do this:

Add Authentication Endpoint: Create a new mutation for user authentication, e.g., userLogin. This mutation should accept credentials (like username and password), authenticate the user against your database, and return a JWT upon successful authentication.

Token Creation and Validation: Use a gem like jwt to handle token creation and validation. The token should include claims like the user ID and expiration time.

Authorize Requests: In your GraphQL controller, before processing any request, validate the JWT token passed in the request headers. If the token is valid, proceed with the request; otherwise, return an authentication error.

User Context: Upon successful token validation, you could set a current user context that can be accessed in your resolvers to apply user-specific logic and permissions.

Suggesting New Queries/Mutations
With authentication in place, you can safely add user-specific data and actions. Here are some ideas:

User Profile Management:

Queries to fetch user profiles, and mutations to update user details, change passwords, or set user preferences.
Advanced Workout Filtering:

Queries to filter workouts by different parameters like difficulty, duration, type (cardio, strength, etc.), or custom tags.
Social Features:

Mutations to follow/unfollow users, and queries to fetch workouts shared by followed users or trending in the user community.
Workout Feedback and Analytics:

Mutations to rate a workout or provide feedback, and queries to fetch user workout history, statistics, or progress over time.
Personalized Workout Plans:

Queries to get personalized workout recommendations based on user goals, preferences, or past workouts, and mutations to subscribe to or customize these plans.
Integration with External Services:

If you plan on integrating with fitness trackers or other external services, you could add queries/mutations to sync data, fetch external workout sessions, or update user settings on those platforms.
For each new feature, consider how it will be used by your front-end clients and the permissions required. Make sure to structure your queries and mutations to be flexible enough to accommodate different client needs while ensuring data security and privacy through proper authorization checks.



## ChatGPT suggested improvments:
Enhancing the functionality of your workout tracking GraphQL API can significantly improve user experience and engagement. Here are some additional features that could provide substantial value to your users:

Social Sharing and Community Engagement:

Allow users to share their workout progress, achievements, and workout plans with a community or on social media.
Implement community features such as workout challenges, leaderboards, and user-generated content to foster a sense of community and motivation.
Personalized Workout Recommendations:

Introduce AI or machine learning algorithms to analyze user performance and preferences to suggest personalized workout programs.
Offer adaptive workout plans that evolve based on user progress and feedback.
Advanced Analytics and Reporting:

Provide detailed analytics on user performance over time, including progress tracking towards specific goals.
Implement visual reports and dashboards that display workout trends, improvements in performance data, and comparisons against user-set goals.
Integration with Wearable Devices:

Allow integration with wearable fitness trackers and smartwatches to automatically log workouts and capture real-time performance data such as heart rate, steps, and calories burned.
Use data from wearable devices to enhance workout recommendations and provide insights into workout effectiveness and health impacts.
Nutrition Tracking and Recommendations:

Incorporate nutrition tracking features to allow users to log meals and track caloric intake, macros, and nutritional information.
Offer nutrition plans that complement workout programs, including meal suggestions and recipes tailored to fitness goals.
Rest and Recovery Insights:

Provide insights into optimal rest periods and recovery strategies based on workout intensity and user feedback.
Integrate features like sleep tracking and stress management to offer a holistic approach to fitness and wellbeing.
Virtual Coaching and Workouts:

Introduce virtual coaching sessions, where users can access personalized training advice and guided workout sessions.
Offer live or pre-recorded video workouts that users can follow along with, including options for various fitness levels and interests.
Goal Setting and Achievement Badges:

Implement a feature for users to set short-term and long-term fitness goals, with progress tracking and reminders.
Reward users with achievement badges or rewards for hitting milestones, completing challenges, or maintaining consistent workout habits.
In-app Messaging or Forums:

Create an in-app messaging system or forums where users can connect, share advice, ask questions, and offer support to one another.
Accessibility and Inclusivity Features:

Ensure the app is accessible to people with disabilities by following best practices for accessibility in design and functionality.
Include workout modifications and options to cater to a wide range of physical abilities and fitness levels.
By integrating these features, your API can provide a more comprehensive, engaging, and personalized fitness platform that caters to a wider audience and their evolving fitness needs.

## How to Access Freinds

med=User.find(1)
mate = User.find(5)
med.add_friend(mate)
med.all_friends
mate.all_friends
