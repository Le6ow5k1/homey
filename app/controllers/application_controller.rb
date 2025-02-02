class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    # For development purposes, always return the first user or create one if none exists
    @current_user ||= User.first_or_create!(
      name: 'Test User',
      email: 'test@example.com'
    )
  end
end
