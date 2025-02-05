class StatusChangesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    result = CreateStatusChangeActivity.call(
      project: @project,
      user: current_user,
      status_change_params: status_change_params
    )
    @activity = result[:activity]

    if result[:success]
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @activity.project, notice: 'Project status was successfully updated.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'status_change_form',
            StatusChangeFormComponent.new(
              project: @activity.project,
              status_change: @activity.subject
            )
          )
        end
        format.html { redirect_to @activity.project, alert: 'Unable to update project status.' }
      end
    end
  end

  private

  def status_change_params
    params.require(:status_change).permit(:new_status, :change_reason)
  end
end
