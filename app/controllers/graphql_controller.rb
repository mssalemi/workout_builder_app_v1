# typed: false
# frozen_string_literal: true

class GraphqlController < ApplicationController
  skip_before_action :verify_authenticity_token

  # If accessing from outside this domain, nullify the session
  # This allows for outside API access while preventing CSRF attacks,
  # but you'll have to authenticate your user separately
  # protect_from_forgery with: :null_session

  def execute
    variables = prepare_variables(params[:variables])
    query = params[:query]
    operation_name = params[:operationName]
    context = {
      current_user: current_user,
    }
    result = WorkoutBuilderAppV1Schema.execute(query, variables: variables, context: context, operation_name: operation_name)
    render json: result
  rescue StandardError => e
    raise e unless Rails.env.development?
    handle_error_in_development(e)
  end

  private

  # Extracts the token from the Authorization header and decodes it to authenticate the user
  def current_user
    token = request.headers['Authorization']&.split(' ')&.last
    return if token.blank?


    # Decode the token (assuming you have a method to do this)
    payload = JsonWebToken.decode(token)

    return if payload.blank?

    user_id = payload['user_id'].to_i

    user = User.find(user_id)

    user
    # Find the user from the decoded token payload
  rescue => e
    # Handle token decode errors, e.g., expired or invalid token
    nil
  end

  # Handle variables in form data, JSON body, or a blank value
  def prepare_variables(variables_param)
    case variables_param
    when String
      if variables_param.present?
        JSON.parse(variables_param) || {}
      else
        {}
      end
    when Hash
      variables_param
    when ActionController::Parameters
      variables_param.to_unsafe_hash # GraphQL-Ruby will validate name and type of incoming variables.
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{variables_param}"
    end
  end

  def handle_error_in_development(e)
    logger.error e.message
    logger.error e.backtrace.join("\n")

    render json: { errors: [{ message: e.message, backtrace: e.backtrace }], data: {} }, status: 500
  end
end
