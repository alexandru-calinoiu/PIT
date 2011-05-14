class PitsController < ApplicationController
  # GET /pits
  # GET /pits.xml
  def index
    if params["search"].nil?
      @pits = Pit.all
    else
      @pits = Pit.find_all_by_latitude(params["search"])
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pits }
      format.json{
        data = {"Pits" => {"data" => @pits}}
        render :json => data.to_json
      }
    end
  end

  def report
    email = params[:email]
    user = User.find_by_email(email) || User.create(:email => email)

    Pit.create(:latitude => params[:latitude], :longitude => params[:longitude], :user => user) if user.valid?

    respond_to do |format|
      format.xml  { head :ok }
    end
  end
end
