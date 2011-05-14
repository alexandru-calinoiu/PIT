class PitsController < ApplicationController
  # GET /pits
  # GET /pits.xml
  def index
    @pits = Pit.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pits }
    end
  end

  def report
    pit = Pit.new
    pit.latitude = params[:latitude]
    pit.longitude = params[:longitude]
    pit.save
    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
