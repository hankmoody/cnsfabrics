class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    if params[:search].nil? || params[:search].empty?
      @fabrics = Fabric
    else
      @fabrics = Fabric.search(params[:search])
    end
    @fabrics = @fabrics.order_by(:created_at.desc).page(params[:page]).per(24)
  end

  def admin
  end
end
