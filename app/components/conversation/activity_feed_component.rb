class Conversation::ActivityFeedComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(project:, page: 1)
    @project = project
    @activity_feed = project.activity_feed(page:)
  end

  private

  attr_reader :project, :activity_feed
end 