class StatusChangesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @status_change = @project.status_changes.build(status_change_params)
    @status_change.previous_status = @project.status

    if @status_change.save
      @project.update!(status: @status_change.new_status)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: 'Project status was successfully updated.' }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            'status_change_form',
            partial: 'status_changes/form',
            locals: { project: @project, status_change: @status_change }
          )
        }
        format.html { redirect_to @project, alert: 'Unable to update project status.' }
      end
    end
  end

  private

  def status_change_params
    params.require(:status_change)
          .permit(:new_status, :change_reason)
          .merge(user: current_user)
  end
end 