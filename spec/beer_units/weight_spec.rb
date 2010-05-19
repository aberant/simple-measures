require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe BeerUnits::Weight do
  describe "basics" do
    before :each do
      BeerUnits::Weight.add_unit :grams, 1000
    end

    it "can be told to accept units and values" do
      weight = BeerUnits::Weight.new(42, :grams)
      weight.value.should == 42
      weight.unit.should == :grams
    end

    it "does not accept units it doesn't know about" do
      lambda {
        BeerUnits::Weight.new(42, :blarghs)
      }.should raise_error
    end

    it "should know equality" do
      weight1 = BeerUnits::Weight.new(42, :grams)
      weight2 = BeerUnits::Weight.new(42, :grams)

      weight1.should == weight2
    end

    it "should know aliases for the same unit" do
      BeerUnits::Weight.add_alias :grams, :gram

      weight = BeerUnits::Weight.new(1, :gram)
      weight.value.should == 1
      weight.unit.should == :gram
    end
  end
  describe "conversion" do
    before :each do
      BeerUnits::Weight.add_unit :grams, 1000
      BeerUnits::Weight.add_unit :pounds, 453_592.37
      BeerUnits::Weight.add_alias :pounds, :pound
    end

    it "should convert from grams to pounds" do
      weight = BeerUnits::Weight.new(907.18474, :grams)

      weight.to_pounds.should == BeerUnits::Weight.new(2, :pounds)
    end
  end
end