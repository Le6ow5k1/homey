class CommentFormComponent < ViewComponent::Base
  def initialize(project:, comment: nil)
    @project = project
    @comment = comment || project.comments.build
  end

  private

  attr_reader :project, :comment
end
