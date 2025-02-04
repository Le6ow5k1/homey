class CommentComponent < ViewComponent::Base
  include ApplicationHelper
  include ProjectsHelper

  def initialize(comment:)
    @comment = comment
  end

  private

  attr_reader :comment
end
