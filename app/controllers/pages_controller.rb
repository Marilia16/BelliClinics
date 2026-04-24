class PagesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    if params[:id] && template_exists?(params[:id], ["pages"])
      render params[:id]
    else
      redirect_to '/404.html', :status => 404
    end
  end

end
