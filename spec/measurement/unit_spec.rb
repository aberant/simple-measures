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

    Measurement::Registry.add_unit :milliliter, 1, :volume
    Measurement::Registry.add_alias :milliliter, :milliliters

    Measurement::Registry.add_unit :fluid_ounce, 28.413, :volume
    Measurement::Registry.add_alias :fluid_ounce, :fl_oz
  end

  describe "basics" do
    it "does not accept units it doesn't know about" do
      lambda {
        Measurement::Unit.new( 42, :blarghs )
      }.should raise_error( Measurement::InvalidUnitError )
    end

    it "should know aliases for the same unit" do
      Measurement::Unit.new( 2, :grams ).should == Measurement::Unit.new( 2, :gram )
    end
  end

  describe "equality" do
    it "should know basic equality" do
      weight1 = Measurement::Unit.new( 42, :grams )
      weight2 = Measurement::Unit.new( 42, :grams )

      weight1.should == weight2
    end

    it "should know equality between convertable units" do
      weight1 = Measurement::Unit.new( 4, :grams )
      weight2 = Measurement::Unit.new( 4000, :milligrams )

      weight1.should == weight2
    end
  end

  describe "conversion" do
    it "should convert from grams to pounds" do
      weight = Measurement::Unit.new( 907.18474, :grams )

      weight.convert_to( :pounds ).should == Measurement::Unit.new( 2, :pounds )
    end

    it "should convert from grams to milligrams" do
      weight = Measurement::Unit.new( 2, :grams )
      weight.convert_to( :milligrams ).should == Measurement::Unit.new( 2000, :milligrams )
    end

    it "should have convience methods for the unit" do
      weight = Measurement::Unit.new( 2, :grams )
      weight.to_milligram.should == Measurement::Unit.new( 2000, :milligrams )
    end

    it "should have convience methods for the alias" do
      weight = Measurement::Unit.new( 2, :grams )
      weight.to_milligrams.should == Measurement::Unit.new( 2000, :milligrams )
    end

    it "blows up if there is not a unit for a convience method" do
      weight = Measurement::Unit.new( 2, :grams )
      lambda{
        weight.to_blarghs
      }.should raise_error( NoMethodError )
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * Measurement::Unit.new( 2,:pounds )
      result.should == Measurement::Unit.new( 4, :pounds )
    end

    it "is able to divide" do
      result = Measurement::Unit.new( 8,:pounds ) / 2
      result.should == Measurement::Unit.new( 4, :pounds )
    end
  end

  describe "addition" do
    it "should be able to add two items of the exact same units" do
      ( Measurement::Unit.new( 1, :gram ) +
        Measurement::Unit.new( 1, :gram ) ).should == Measurement::Unit.new( 2, :grams )
    end

    it "should be able to add two items of the same units with one using an alias" do
      ( Measurement::Unit.new( 1, :gram ) +
        Measurement::Unit.new( 2, :grams ) ).should == Measurement::Unit.new( 3, :grams )
    end

    it "should not be able to add items of different types" do
      lambda {
        Measurement::Unit.new( 1, :gram ) + Measurement::Unit.new( 1, :milliliter)
      }.should raise_error(ArgumentError)
    end
  end

  describe "subtraction" do
    it "should be able to subtract two items of the exact same units" do
      ( Measurement::Unit.new( 5, :gram ) -
        Measurement::Unit.new( 1, :gram ) ).should == Measurement::Unit.new( 4, :grams )
    end

    it "should be able to subtract two items of the same units with one using an alias" do
      ( Measurement::Unit.new( 6, :gram ) -
        Measurement::Unit.new( 3, :grams ) ).should == Measurement::Unit.new( 3, :grams )
    end

    it "should not be able to subtract items of different types" do
      lambda {
        Measurement::Unit.new( 1, :gram ) - Measurement::Unit.new( 1, :milliliter)
      }.should raise_error(ArgumentError)
    end
  end
end