class HomeController < ApplicationController

  def index
    @location = "Bucuresti"

    respond_to do |format|
      format.html
    end
  end

end
