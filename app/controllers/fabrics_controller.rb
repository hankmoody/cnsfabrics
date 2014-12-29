class FabricsController < ApplicationController
  before_filter :authenticate_user!

  def excel_update
    @jobs = {}
    @update_status = {}
    file = view_context.rename_file(params[:excel_file].path,
                                    params[:excel_file].path + '.xlsx')
    begin
      sheet = FabricSheetReader.new(file)
      records = sheet.read_fabric_data
      records.each do |record|
        view_context.process_record record
      end
    rescue => e
      flash[:error] = e.to_s
      redirect_to admin_path
    end
  end

  def fetch
    job_id = params[:job_id]
    job_status = {
      :message => Sidekiq::Status::get(job_id, :status_message),
      :status => Sidekiq::Status::get(job_id, :status_code)
    }
    if Sidekiq::Status::complete? job_id
      render :status => 200, :json => job_status
    elsif Sidekiq::Status::failed? job_id
      render :status => 500, :json => job_status
    else
      render :status => 202, :json => job_status
    end
  end

  def fabric_params
    params.require(:fabric).permit(:code, :width, :quantity)
  end
end
