class PagesController < ApplicationController

  def index
    @location = params[:location] if !params[:location].nil?

    respond_to do |format|
      format.html
    end
  end

end
