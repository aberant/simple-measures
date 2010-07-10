require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

module BeerUnits
  class Unit
    include UnitAbilities
  end
end

describe BeerUnits::Unit do
  before :each do
    BeerUnits::Registry.clear!
    BeerUnits::Registry.add_unit :gram, 1000
    BeerUnits::Registry.add_alias :gram, :grams

    BeerUnits::Registry.add_unit :milligram, 1
    BeerUnits::Registry.add_alias :milligram, :milligrams

    BeerUnits::Registry.add_unit :pound, 453_592.37
    BeerUnits::Registry.add_alias :pound, :pounds
  end

  describe "basics" do
    it "does not accept units it doesn't know about" do
      lambda {
        BeerUnits::Unit.new(42, :blarghs)
      }.should raise_error( BeerUnits::InvalidUnitError )
    end

    it "should know aliases for the same unit" do
      BeerUnits::Unit.new( 2, :grams ).should == BeerUnits::Unit.new( 2, :gram )
    end
  end

  describe "equality" do
    it "should know basic equality" do
      weight1 = BeerUnits::Unit.new(42, :grams)
      weight2 = BeerUnits::Unit.new(42, :grams)

      weight1.should == weight2
    end

    it "should know equality between convertable units" do
      weight1 = BeerUnits::Unit.new(4, :grams)
      weight2 = BeerUnits::Unit.new(4000, :milligrams)

      weight1.should == weight2
    end
  end

  describe "conversion" do
    it "should convert from grams to pounds" do
      weight = BeerUnits::Unit.new(907.18474, :grams)

      weight.convert_to(:pounds).should == BeerUnits::Unit.new(2, :pounds)
    end

    it "should convert from grams to milligrams" do
      weight = BeerUnits::Unit.new(2, :grams)
      weight.convert_to(:milligrams).should == BeerUnits::Unit.new(2000, :milligrams)
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * BeerUnits::Unit.new(2,:pounds)
      result.should == BeerUnits::Unit.new(4, :pounds)
    end
  end
end