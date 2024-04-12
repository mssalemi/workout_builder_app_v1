# typed: false
class User < ApplicationRecord
    has_secure_password
  
    # Friendships where this user is the initiating user
    has_many :friendships
    has_many :friends, through: :friendships, source: :friend
  
    # Friendships where this user is the added friend
    has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id'
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    def all_friends
        friends + inverse_friends
    end

    def friends_workouts
        Workout.joins(:user).where(user: friends)
    end

    def add_friend(user)
        # Check if the friendship already exists in either direction
        return if all_friends.include?(user)
      
        # Create the direct friendship
        friends << user unless friends.include?(user)
        
        # Create the inverse friendship if it doesn't already exist
        unless user.friends.include?(self)
          user.friends << self
        end
    end
end
