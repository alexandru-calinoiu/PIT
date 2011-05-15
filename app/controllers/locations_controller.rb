class LocationsController < ApplicationController
  def index
    respond_to do |format|
      format.json {
        @result = search

        results = []
        @result.each do |result|
          result_container = {}
          result_container['id'] = result.id
          result_container['name'] = result.name
          results << result_container
        end
        data = {"Results" => {"data" => results}}
        render :json => data.to_json
      }
    end
  end
end
