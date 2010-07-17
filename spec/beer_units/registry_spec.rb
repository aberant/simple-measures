require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe Measurement::Registry do
  before :each do
    Measurement::Registry.clear!
  end

  it "should be able to add units" do
    Measurement::Registry.add_unit( :milligram, 1, :weight )
    Measurement::Registry.units.should have_key( :milligram )
  end

  it "should be able to add an alias" do
    Measurement::Registry.add_unit( :milligram, 1, :weight )
    Measurement::Registry.add_alias( :milligram, :milligrams )

    Measurement::Registry.aliases.should have_key( :milligrams )
  end

  it "should not be able to add an alias if there is no coresponding unit" do
    lambda{
      Measurement::Registry.add_alias( :milligram, :milligrams )
    }.should raise_error( Measurement::InvalidAliasError )
  end

  it "should return the normalized unit name for a given alias" do
    Measurement::Registry.add_unit( :milligram, 1, :weight )
    Measurement::Registry.add_alias( :milligram, :bob )


    Measurement::Registry.normalized_unit_name( :bob ).should == :milligram
  end

  it "should return the unit conversion value" do
    Measurement::Registry.add_unit( :gram, 1000, :weight )

    Measurement::Registry.unit_conversion_value( :gram ).should == 1000
  end

  it "should return the unit conversion value for an alias" do
    Measurement::Registry.add_unit( :gram, 1000, :weight )
    Measurement::Registry.add_alias( :gram, :grams )

    Measurement::Registry.unit_conversion_value( :grams ).should == 1000
  end

  it "should return the unit type" do
    Measurement::Registry.add_unit( :gram, 1000, :weight )

    Measurement::Registry.unit_type( :gram ).should == :weight
  end

  it "should return the unit type for an alias" do
    Measurement::Registry.add_unit( :gram, 1000, :weight )
    Measurement::Registry.add_alias( :gram, :grams )

    Measurement::Registry.unit_type( :grams ).should == :weight
  end

  it "should be able to return the smallest unit for a type" do
    Measurement::Registry.add_unit( :gram, 1000, :weight )
    Measurement::Registry.add_unit( :milligram, 1, :weight )
    Measurement::Registry.add_unit :pound, 453_592.37, :weight
    Measurement::Registry.add_unit( :fluid_ounces, 1, :volume )

    Measurement::Registry.smallest_unit_for_type( :weight ).should == :milligram
  end
end