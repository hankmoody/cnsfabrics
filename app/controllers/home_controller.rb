class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    # @fabrics = Fabric.order(created_as: :desc).page(params[:page])
    @fabrics = Fabric.all
  end

  def admin
  end
end
