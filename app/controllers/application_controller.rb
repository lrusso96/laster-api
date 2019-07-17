# frozen_string_literal: true

# Main application controller, includes some modules to catch exceptions
class ApplicationController < ActionController::API
  include Response
  include ExceptionHandler
end
