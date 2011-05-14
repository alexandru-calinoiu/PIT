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
end
