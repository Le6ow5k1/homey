class CreateStatusChangeActivity
  def self.call(project:, user:, status_change_params:)
    new(project:, user:, status_change_params:).call
  end

  def initialize(project:, user:, status_change_params:)
    @project = project
    @user = user
    @status_change_params = status_change_params
  end

  def call
    status_change = StatusChange.new(status_change_params.merge(
      previous_status: project.status,
      user: user,
      project: project
    ))
    activity = project.activities.build(user: user, subject: status_change)

    if activity.save
      project.update!(status: status_change.new_status)
      { success: true, activity: activity }
    else
      { success: false, activity: activity }
    end
  end

  private

  attr_reader :project, :user, :status_change_params
end