class Conversation::StatusChangeComponent < ViewComponent::Base
  def initialize(status_change:)
    @status_change = status_change
  end

  private

  attr_reader :status_change
end 