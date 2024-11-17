class ApplicationController < ActionController::Base
  # protect_from_forgery with: :null_session, if: -> { request.format.json? }
  # Ex:- :null => false
end
