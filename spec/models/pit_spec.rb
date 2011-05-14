require 'spec_helper'

describe Pit do

  before :each do
    @pit = Factory(:pit)
  end

  it "should insert a country if it does not already exists" do
    @pit.country = "England"
    lambda do
      @pit.save
    end.should change(Country, :count).by(1)
  end
end
