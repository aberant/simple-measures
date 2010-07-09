require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe BeerUnits::Weight do
  describe "basics" do
    before :each do
      BeerUnits::Weight.add_unit :gram, 1000
      BeerUnits::Weight.add_alias :gram, :grams

    end

    it "can be told to accept units and values" do
      weight = BeerUnits::Weight.new(42, :grams)
      weight.value.should == 42
      weight.unit.should == :grams
    end

    it "does not accept units it doesn't know about" do
      lambda {
        BeerUnits::Weight.new(42, :blarghs)
      }.should raise_error( BeerUnits::InvalidUnitError )
    end

    it "should know equality" do
      weight1 = BeerUnits::Weight.new(42, :grams)
      weight2 = BeerUnits::Weight.new(42, :grams)

      weight1.should == weight2
    end

    it "should know aliases for the same unit" do

      BeerUnits::Weight.new( 2, :grams ).should == BeerUnits::Weight.new( 2, :gram )
    end
  end
  describe "conversion" do
    before :each do
      BeerUnits::Weight.add_unit :milligram, 1
      BeerUnits::Weight.add_alias :milligram, :milligrams

      BeerUnits::Weight.add_unit :pound, 453_592.37
      BeerUnits::Weight.add_alias :pound, :pounds
    end

    it "should convert from grams to pounds" do
      weight = BeerUnits::Weight.new(907.18474, :grams)

      weight.convert_to(:pounds).should == BeerUnits::Weight.new(2, :pounds)
    end

    it "should convert from grams to milligrams" do
      weight = BeerUnits::Weight.new(2, :grams)
      weight.convert_to(:milligrams).should == BeerUnits::Weight.new(2000, :milligrams)
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * BeerUnits::Weight.new(2,:pounds)
      result.should == BeerUnits::Weight.new(4, :pounds)
    end
  end
end