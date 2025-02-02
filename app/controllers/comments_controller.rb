class CommentsController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @comment = @project.comments.build(comment_params)

    if @comment.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: 'Comment was successfully added.' }
      end
    else
      respond_to do |format|
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            'new_comment_form',
            partial: 'comments/form',
            locals: { project: @project, comment: @comment }
          )
        }
        format.html { redirect_to @project, alert: 'Unable to add comment.' }
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content).merge(user: current_user)
  end
end 