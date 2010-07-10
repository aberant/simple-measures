require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe BeerMeasurement::Registry do
  before :each do
    BeerMeasurement::Registry.clear!
  end

  it "should be able to add units" do
    BeerMeasurement::Registry.add_unit( :milligram, 1, :weight )
    BeerMeasurement::Registry.units.should have_key( :milligram )
  end

  it "should be able to add an alias" do
    BeerMeasurement::Registry.add_unit( :milligram, 1, :weight )
    BeerMeasurement::Registry.add_alias( :milligram, :milligrams )

    BeerMeasurement::Registry.aliases.should have_key( :milligrams )
  end

  it "should not be able to add an alias if there is no coresponding unit" do
    lambda{
      BeerMeasurement::Registry.add_alias( :milligram, :milligrams )
    }.should raise_error( BeerMeasurement::InvalidAliasError )
  end

  it "should return the normalized unit name for a given alias" do
    BeerMeasurement::Registry.add_unit( :milligram, 1, :weight )
    BeerMeasurement::Registry.add_alias( :milligram, :bob )


    BeerMeasurement::Registry.normalized_unit_name( :bob ).should == :milligram
  end

  it "should return the unit conversion value" do
    BeerMeasurement::Registry.add_unit( :gram, 1000, :weight )

    BeerMeasurement::Registry.unit_conversion_value( :gram ).should == 1000
  end

  it "should return the unit conversion value for an alias" do
    BeerMeasurement::Registry.add_unit( :gram, 1000, :weight )
    BeerMeasurement::Registry.add_alias( :gram, :grams )

    BeerMeasurement::Registry.unit_conversion_value( :grams ).should == 1000
  end

  it "should return the unit type" do
    BeerMeasurement::Registry.add_unit( :gram, 1000, :weight )

    BeerMeasurement::Registry.unit_type( :gram ).should == :weight
  end

  it "should return the unit type for an alias" do
    BeerMeasurement::Registry.add_unit( :gram, 1000, :weight )
    BeerMeasurement::Registry.add_alias( :gram, :grams )

    BeerMeasurement::Registry.unit_type( :grams ).should == :weight
  end
end