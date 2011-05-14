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
    email = params[:email]
    user = User.find_by_email email

    if user.nil?
      user = User.create :email => email
    end
    pit.user = user
    pit.save
    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
