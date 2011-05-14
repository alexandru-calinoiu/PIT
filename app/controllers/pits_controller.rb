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
    email = params[:email]
    user = User.find_by_email email unless email.nil?
    if user.nil? && !email.nil?
      user = User.create :email => email
    end
    pit = Pit.create(:latitude => params[:latitude], :longitude => params[:longitude], :user => user) unless params[:longitude].nil? || params[:latitude].nil? || user.nil?
    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
