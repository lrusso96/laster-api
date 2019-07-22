# frozen_string_literal: true

require_relative '../api/laster.rb'

# This module catches some common exceptions and returns nice json to users
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
=begin
    rescue_from ActiveRecord::RecordNotFound do |e|
      json_response({ message: e.message }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end
=end

    rescue_from ActionController::ParameterMissing do |e|
      json_response({ message: e.message }, :bad_request)
    end

    rescue_from Laster::Errors::Simple do |e|
      json_response({ error: e.message, code: e.code }, :bad_request)
    end
  end
end
