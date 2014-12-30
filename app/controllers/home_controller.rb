class HomeController < ApplicationController
  before_filter :authenticate_user!, except: [:index]

  def index
    @search = !params[:search].nil? && !params[:search].empty?
    if ! @search
      @fabrics = Fabric
    else
      @fabrics = Fabric.search(params[:search])
    end
    @fabrics = @fabrics.order_by(:created_at.desc).page(params[:page]).per(24)
  end

  def admin
  end
end
