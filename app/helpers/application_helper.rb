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
end
