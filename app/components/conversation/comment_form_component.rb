class Conversation::CommentFormComponent < ViewComponent::Base
  def initialize(project:)
    @project = project
    @comment = project.comments.build
  end

  private

  attr_reader :project, :comment
end 