# typed: false

module Mutations
    class UserLogin < BaseMutation
      extend T::Sig
  
      description "Authenticate a user and return a JWT"
  
      # Define input arguments
      argument :username, String, required: true, description: "The username of the user trying to log in."
      argument :password, String, required: true, description: "The password of the user trying to log in."
  
      # Define return fields
      field :token, String, null: true, description: "The JWT token for authenticated sessions."
      field :user, Types::UserType, null: true, description: "The authenticated user's data."
      field :errors, [String], null: false, description: "List of authentication errors."
  
      # The resolve method for authentication
      sig { params(username: String, password: String).returns(T::Hash[T.untyped, T.untyped]) }
      def resolve(username:, password:)
        user = User.find_by(username: username)
  
        # Authenticate the user
        if user&.authenticate(password)
          token = JsonWebToken.encode(user_id: user.id)
          { token: token, user: user, errors: [] }
        else
          { token: nil, user: nil, errors: ["Invalid username or password"] }
        end
      end
    end
end
  

#   In this mutation:

# The username and password are taken as input arguments.
# The return type includes a token (the JWT), the user object, and any errors that might occur during authentication.
# The resolve method performs the authentication logic: it looks up the user by username, checks the password using the authenticate method (which you should have from using has_secure_password in your User model), and generates a JWT if the authentication is successful.
# The JsonWebToken.encode method is assumed to be part of a module that you've created for handling JWT encoding and decoding. You'll need to define this part based on your application's specific needs for JWT handling.
# This structure closely follows the conventions used in your AddExerciseToWorkout mutation, maintaining consistency across your GraphQL mutations.