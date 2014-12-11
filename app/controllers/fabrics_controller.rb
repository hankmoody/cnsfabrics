class FabricsController < ActionController::Base
  def fabric_params
    params.require(:fabric).permit(:code, :width, :quantity)
  end
end
