class Conversation::StatusChangeComponent < ViewComponent::Base
  include ApplicationHelper
  include ProjectsHelper
  
  def initialize(status_change:)
    @status_change = status_change
  end

  private

  attr_reader :status_change
end 