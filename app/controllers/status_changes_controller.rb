class StatusChangesController < ApplicationController
  def create
    @project = Project.find(params[:project_id])
    @activity = @project.activities.build(
      user: current_user,
      subject: StatusChange.new(status_change_params.merge(
                                  previous_status: @project.status,
                                  project: @project,
                                  user: current_user
                                ))
    )

    if @activity.save
      @project.update!(status: @activity.subject.new_status)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to @project, notice: 'Project status was successfully updated.' }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace(
            'status_change_form',
            StatusChangeFormComponent.new(
              project: @project,
              status_change: @activity.subject
            )
          )
        end
        format.html { redirect_to @project, alert: 'Unable to update project status.' }
      end
    end
  end

  private

  def status_change_params
    params.require(:status_change).permit(:new_status, :change_reason)
  end
end
