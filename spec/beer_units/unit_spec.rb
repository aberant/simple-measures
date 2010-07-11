require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe Measurement::Unit do
  before :each do
    Measurement::Registry.clear!
    Measurement::Registry.add_unit :gram, 1000, :weight
    Measurement::Registry.add_alias :gram, :grams

    Measurement::Registry.add_unit :milligram, 1, :weight
    Measurement::Registry.add_alias :milligram, :milligrams

    Measurement::Registry.add_unit :pound, 453_592.37, :weight
    Measurement::Registry.add_alias :pound, :pounds
  end

  describe "basics" do
    it "does not accept units it doesn't know about" do
      lambda {
        Measurement::Unit.new(42, :blarghs)
      }.should raise_error( Measurement::InvalidUnitError )
    end

    it "should know aliases for the same unit" do
      Measurement::Unit.new( 2, :grams ).should == Measurement::Unit.new( 2, :gram )
    end
  end

  describe "equality" do
    it "should know basic equality" do
      weight1 = Measurement::Unit.new(42, :grams)
      weight2 = Measurement::Unit.new(42, :grams)

      weight1.should == weight2
    end

    it "should know equality between convertable units" do
      weight1 = Measurement::Unit.new(4, :grams)
      weight2 = Measurement::Unit.new(4000, :milligrams)

      weight1.should == weight2
    end
  end

  describe "conversion" do
    it "should convert from grams to pounds" do
      weight = Measurement::Unit.new(907.18474, :grams)

      weight.convert_to(:pounds).should == Measurement::Unit.new(2, :pounds)
    end

    it "should convert from grams to milligrams" do
      weight = Measurement::Unit.new(2, :grams)
      weight.convert_to(:milligrams).should == Measurement::Unit.new(2000, :milligrams)
    end

    it "should have convience methods" do
      weight = Measurement::Unit.new(2, :grams)
      weight.to_milligrams.should == Measurement::Unit.new(2000, :milligrams)
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * Measurement::Unit.new(2,:pounds)
      result.should == Measurement::Unit.new(4, :pounds)
    end
  end
end