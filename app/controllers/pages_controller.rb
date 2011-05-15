class PagesController < ApplicationController

  def index
    @depth = session[:depth] || -1
    @breadcrumb = session[:breadcrumb] || ""
    @location = @breadcrumb unless @breadcrumb.empty?

    if @depth < 3
      move_next
    else
      move_next if session[:depth] < 4
      if search.class.name == 'Street'
        @pits = search.pits
      end

    end

    respond_to do |format|
      format.html
    end
  end

  def clear
    init_search

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def show_all
    @depth = session[:depth] || -1
    @breadcrumb = session[:breadcrumb] || ""
    @location = @breadcrumb unless @breadcrumb.empty?

    city = @breadcrumb.split(";").last

    @streets = City.find_by_name(city).streets.all.sort { |a, b| b.pits.count <=> a.pits.count }
    @pits = []
    @streets.each do |street|
      @pits = @pits + street.pits.all
    end

    respond_to do |format|
      format.html { render 'index' }
    end
  end

  def worst
    go_to_worst_street

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

end
