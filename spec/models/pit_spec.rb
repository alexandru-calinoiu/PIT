require 'spec_helper'

describe Pit do
  it "should insert a country if it does not already exists" do
    lambda do
      Factory(:pit)
    end.should change(Country, :count).by(1)
  end

  it "should not insert a country if it does already exists" do
    Factory(:country)
    lambda do
      Factory(:pit)
    end.should_not change(Country, :count)
  end

  it "should insert county if it does not already exists" do
    lambda do
      Factory(:pit)
    end.should change(County, :count).by(1)
  end

  it "should not insert county if it already exists" do
    Factory(:county)
    lambda do
      Factory(:pit)
    end.should_not change(County, :count)
  end

  it "should insert city if it does not already exists" do
    lambda do
      Factory(:pit)
    end.should change(City, :count).by(1)
  end

  it "should not insert city if it does not already exists" do
    Factory(:city)
    lambda do
      Factory(:pit)
    end.should_not change(City, :count)
  end

  it "should insert street if it does not already exists" do
    lambda do
      Factory(:pit)
    end.should change(Street, :count).by(1)
  end

  it "should not insert street if it does already exists" do
    Factory(:street)
    lambda do
      Factory(:pit)
    end.should_not change(Street, :count)
  end

  it "should not be valid for invalid latitude and longitude" do
    pit = Pit.new(:latitude => 1, :longitude => 2)
    pit.should_not be_valid
  end
end
