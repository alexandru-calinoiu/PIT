require ""

class PagesController < ApplicationController

  def index
    @depth = session[:depth] || -1
    @breadcrumb = session[:breadcrumb] || ""
    @location = @breadcrumb unless @breadcrumb.empty?
    @map = Cartographer::Gmap.new('map')
    @map.zoom = :bound
    @icon = Cartographer::Gicon.new()
    @map.icons << @icon

    if @depth < 3
      move_next
    else
      move_next if session[:depth] < 4
      if search.class.name == 'Street'
        @pits = search.pits
      end
    end

    marker1 = Cartographer::Gmarker.new(:name=> "taj_mahal", :marker_type => "Building",
                                        :position => [27.173006, 78.042086],
                                        :info_window_url => "/url_for_info_content", :icon => @icon)
    marker2 = Cartographer::Gmarker.new(:name=> "raj_bhawan", :marker_type => "Building",
                                        :position => [28.614309, 77.201353],
                                        :info_window_url => "/url_for_info_content", :icon => @icon)

    @map.markers << marker1
    @map.markers << marker2

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
