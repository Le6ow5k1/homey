class CreateCommentActivity
  def self.call(project:, user:, comment_params:)
    new(project:, user:, comment_params:).call
  end

  def initialize(project:, user:, comment_params:)
    @project = project
    @user = user
    @comment_params = comment_params
  end

  def call
    comment = Comment.new(comment_params.merge(
      user: user,
      project: project
    ))
    activity = project.activities.build(user: user, subject: comment)

    if activity.save
      { success: true, activity: activity }
    else
      { success: false, activity: activity }
    end
  end

  private

  attr_reader :project, :user, :comment_params
end 