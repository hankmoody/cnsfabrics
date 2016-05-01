class HomeController < ApplicationController
  before_filter :authenticate_user!, only: [:admin]

  def index
    @search = !params[:search].nil? && !params[:search].empty?
    if ! @search
      @fabrics = Fabric.order_by(:created_at.desc)
    else
      @fabrics = Kaminari.paginate_array(Fabric.search(params[:search]))
    end
    @fabrics = @fabrics.page(params[:page]).per(24)
  end

  def madrascheck
    @fabrics = Kaminari.paginate_array(Fabric.search('madras'))
    @fabrics = @fabrics.page(params[:page]).per(24)
  end

  def admin
  end
end
