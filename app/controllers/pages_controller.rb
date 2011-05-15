class PagesController < ApplicationController

  def index
    @depth = session[:depth] || -1
    @breadcrumb = session[:breadcrumb] || ""
    @location = @breadcrumb unless @breadcrumb.empty?

    if session[:depth] < 3
      move_next
    else
      move_next if session[:depth] < 4
      @pits = search.pits
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

end
