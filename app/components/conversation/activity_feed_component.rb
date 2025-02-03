class Conversation::ActivityFeedComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(project:, current_page:)
    @project = project
    @activity_feed = project.activity_feed(page: current_page)
  end

  private

  attr_reader :project, :activity_feed
end 