class FabricsController < ApplicationController
  before_filter :authenticate_user!, except: [:show]

  def show
    @fabric = Fabric.find(params[:id])
  end

  def destroy
    Fabric.find(params[:id]).destroy
    redirect_to root_path
  end

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
    elsif Sidekiq::Status::queued? job_id
      render :status => 202, :json => {
        :message => 'Job queued...',
        :status => 'info'
      }
    else
      render :status => 202, :json => job_status
    end
  end

  def crop
    fabric = Fabric.find(params[:id])
    new_image = params[:new_image]
    dimensions = FastImage.size(new_image)
    if dimensions[0] < 600
      render :status => 500, :json => { 'message' => 'Image must be at least 600 px wide!' }
    else
      fabric.is_cropped = true
      fabric.image = URI.parse(new_image)
      fabric.save!
    end
    render :json => { 'blah' => new_image }
  end

  def fabric_params
    params.require(:fabric).permit(:code, :width, :quantity)
  end
end
