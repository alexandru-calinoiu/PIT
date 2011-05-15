module ApplicationHelper
  def title
    base_title = "PIT"

    if @title.nil?
      "#{base_title} | #{location}"
    else
      "#{base_title} | #{@title}"
    end
  end

  def location
    # should determine user location
    default_location = "Sibiu"

    if @location.nil?
      default_location
    else
      @location
    end
  end

  def init_search
    @depth = session[:depth] = -1
    @breadcrumb = session[:breadcrumb] = ""
  end

  def move_next

    if @breadcrumb.empty?
      @breadcrumb += "#{params["search_term"]}"
    else
      @breadcrumb += ";#{params["search_term"]}"
    end

    @depth = @depth + 1

    session[:breadcrumb] = @breadcrumb
    session[:depth] = @depth

    @location = @breadcrumb unless @breadcrumb.empty?
  end

  def search
    search_term = params["search"]
    breadcrumbs = session[:breadcrumb].split(";")

    if breadcrumbs.count >= 0
      search = breadcrumbs[0] || search_term
      if search.to_s.empty?
        @result = Country.all
      else
        @result = breadcrumbs.count == 0 ? Country.where("name like ?", "%#{search}%") : Country.find_by_name(search)
      end
    end

    if breadcrumbs.count >= 1
      search = breadcrumbs[1] || search_term
      if search.to_s.empty?
        @result = @result.counties
      else
        @result = breadcrumbs.count == 1 ? @result.counties.where("name like ?", "%#{search}%") : @result.counties.find_by_name(search)
      end
    end

    if breadcrumbs.count >= 2
      search = breadcrumbs[2] || search_term
      if search.to_s.empty?
        @result = @result.cities
      else
        @result = breadcrumbs.count == 2 ? @result.cities.where("name like ?", "%#{search}%") : @result.cities.find_by_name(search)
      end
    end

    if breadcrumbs.count >= 3
      search = breadcrumbs[3] || search_term
      if search.to_s.empty?
        @result = @result.streets.all
      else
        @result = breadcrumbs.count == 3 ? @result.streets.where("name like ?", "%#{search}%") : @result.streets.find_by_name(search)
      end
    end

    @result
  end
end
