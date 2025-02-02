class Conversation::HistoryComponent < ViewComponent::Base
  def initialize(project:, page: 1)
    @project = project
    @conversation = project.conversation_history(page:)
  end

  private

  attr_reader :project, :conversation
end 