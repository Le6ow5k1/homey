class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    result = CreateCommentActivity.call(project: @project, user: current_user, comment_params: comment_params)
    @activity = result[:activity]

    if result[:success]
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @activity.project, notice: 'Comment was successfully added.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'new_comment_form',
            CommentFormComponent.new(
              project: @activity.project,
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
