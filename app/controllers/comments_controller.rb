class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @activity = @project.activities.build(
      user: current_user,
      subject: Comment.new(comment_params.merge(project: @project, user: current_user))
    )

    if @activity.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: 'Comment was successfully added.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'new_comment_form',
            CommentFormComponent.new(
              project: @project,
              comment: @activity.subject
            )
          )
        end
        format.html { redirect_to @project, alert: 'Unable to add comment.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
