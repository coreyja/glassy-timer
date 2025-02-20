# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Clearance::Controller
  include ViewLookupByModule
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
