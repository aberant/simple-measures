require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe BeerMeasurement::Unit do
  before :each do
    BeerMeasurement::Registry.clear!
    BeerMeasurement::Registry.add_unit :gram, 1000, :weight
    BeerMeasurement::Registry.add_alias :gram, :grams

    BeerMeasurement::Registry.add_unit :milligram, 1, :weight
    BeerMeasurement::Registry.add_alias :milligram, :milligrams

    BeerMeasurement::Registry.add_unit :pound, 453_592.37, :weight
    BeerMeasurement::Registry.add_alias :pound, :pounds
  end

  describe "basics" do
    it "does not accept units it doesn't know about" do
      lambda {
        BeerMeasurement::Unit.new(42, :blarghs)
      }.should raise_error( BeerMeasurement::InvalidUnitError )
    end

    it "should know aliases for the same unit" do
      BeerMeasurement::Unit.new( 2, :grams ).should == BeerMeasurement::Unit.new( 2, :gram )
    end
  end

  describe "equality" do
    it "should know basic equality" do
      weight1 = BeerMeasurement::Unit.new(42, :grams)
      weight2 = BeerMeasurement::Unit.new(42, :grams)

      weight1.should == weight2
    end

    it "should know equality between convertable units" do
      weight1 = BeerMeasurement::Unit.new(4, :grams)
      weight2 = BeerMeasurement::Unit.new(4000, :milligrams)

      weight1.should == weight2
    end
  end

  describe "conversion" do
    it "should convert from grams to pounds" do
      weight = BeerMeasurement::Unit.new(907.18474, :grams)

      weight.convert_to(:pounds).should == BeerMeasurement::Unit.new(2, :pounds)
    end

    it "should convert from grams to milligrams" do
      weight = BeerMeasurement::Unit.new(2, :grams)
      weight.convert_to(:milligrams).should == BeerMeasurement::Unit.new(2000, :milligrams)
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * BeerMeasurement::Unit.new(2,:pounds)
      result.should == BeerMeasurement::Unit.new(4, :pounds)
    end
  end
end