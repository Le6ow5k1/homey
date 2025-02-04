class StatusChangeFormComponent < ViewComponent::Base
  def initialize(project:, status_change: nil)
    @project = project
    @status_change = status_change || project.status_changes.build
  end

  private

  attr_reader :project, :status_change
end
