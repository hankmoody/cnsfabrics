class FabricsController < ApplicationController
  before_filter :authenticate_user!

  def excel_update
    @dbox = DropboxBridge.new
    @status = []
    file = view_context.rename_file(params[:excel_file].path,
                                    params[:excel_file].path + '.xlsx')
    begin
      sheet = FabricSheetReader.new(file)
      records = sheet.read_fabric_data
      records.each do |record|
        view_context.process_record record
      end
    rescue => e
      @status << { :danger => e.to_s }
    end
  end

  def fabric_params
    params.require(:fabric).permit(:code, :width, :quantity)
  end

end
