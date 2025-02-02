class Conversation::StatusChangeFormComponent < ViewComponent::Base
  def initialize(project:)
    @project = project
    @status_change = project.status_changes.build
  end

  private

  attr_reader :project, :status_change
end 