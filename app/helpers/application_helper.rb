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

  def go_to_worst_street
    @depth = session[:depth] || 0
    if (@depth==0)
      begin
        @street_info = Pit.count(:joins => "join streets s on  street_id=s.id", :group => "s.id", :order =>'count_all desc', :limit => 1)
        @street = Street.find(@street_info.first.first)
        set_bread_crumb(@street)
      end
    end

    if (@depth==1)
      begin
        country_name=session[:breadcrumb]
        country = Country.find_by_name(country_name)
        counties = County.find_all_by_country_id(country.id).map { |c| c.id }
        cities = City.where(:county_id => counties).map { |c| c.id }
        streets = Street.where(:city_id => cities)
        @street = streets.max {|a,b| a.pits.count <=> b.pits.count}
        set_bread_crumb(@street)
      end
    end

    if (@depth==2)
      begin
        bread_crumb=session[:breadcrumb]
        parts = bread_crumb.split(";")
        country_name = parts[0]
        country = Country.find_by_name(country_name)
        county_name = parts[1]
        county = County.find_by_name_and_country_id(county_name, country.id)
        cities = City.find_all_by_county_id(county.id).map { |c| c.id }
        streets = Street.where(:city_id => cities)
        @street = streets.max {|a,b| a.pits.count <=> b.pits.count}
        set_bread_crumb(@street)
      end
    end

    if (@depth>=3)
      begin
        bread_crumb=session[:breadcrumb]
        parts = bread_crumb.split(";")
        country_name = parts[0]
        country = Country.find_by_name(country_name)
        county_name = parts[1]
        county = County.find_by_name_and_country_id(county_name, country.id)
        city_name = parts[2]
        city = City.find_by_name_and_county_id(city_name, county.id)
        streets = Street.find_all_by_city_id(city.id)
        @street = streets.max {|a,b| a.pits.count <=> b.pits.count}
        set_bread_crumb(@street)
      end
    end
  end

  def set_bread_crumb(street)
    @breadcrumb = session[:breadcrumb] = ""
    city = street.city
    county = city.county
    country = county.country
    @breadcrumb = country.name + ";" + county.name + ";" + city.name + ";" + street.name
    @depth = 4
    @pits = street.pits
    session[:depth] = @depth
    session[:breadcrumb] = @breadcrumb
  end
end
