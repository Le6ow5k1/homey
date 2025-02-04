class ActivityFeedComponent < ViewComponent::Base
  include Turbo::FramesHelper

  def initialize(project:, current_page:, per_page: 10)
    @project = project
    @current_page = [current_page.to_i, 1].max
    @per_page = per_page
  end

  def page
    @page ||= [current_page.to_i, 1].max
  end

  def total_pages
    @total_pages ||= (project.activities.count.to_f / per_page).ceil
  end

  attr_reader :project, :current_page, :per_page

  private

  def activities
    @activities ||= project.activities
                           .order(created_at: :desc)
                           .includes(subject: [:user])
                           .limit(per_page)
                           .offset((page - 1) * per_page)
  end
end
