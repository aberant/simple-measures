require File.join( File.dirname(__FILE__) , '..', 'spec_helper' )

describe SimpleMeasures::Unit do
  before :each do
    SimpleMeasures::Registry.clear!
    SimpleMeasures::Registry.add_unit :gram, 1000, :weight
    SimpleMeasures::Registry.add_alias :gram, :grams

    SimpleMeasures::Registry.add_unit :milligram, 1, :weight
    SimpleMeasures::Registry.add_alias :milligram, :milligrams

    SimpleMeasures::Registry.add_unit :pound, 453_592.37, :weight
    SimpleMeasures::Registry.add_alias :pound, :pounds

    SimpleMeasures::Registry.add_unit :milliliter, 1, :volume
    SimpleMeasures::Registry.add_alias :milliliter, :milliliters

    SimpleMeasures::Registry.add_unit :fluid_ounce, 28.413, :volume
    SimpleMeasures::Registry.add_alias :fluid_ounce, :fl_oz
  end

  describe "basics" do
    it "does not accept units it doesn't know about" do
      lambda {
        SimpleMeasures::Unit.new( 42, :blarghs )
      }.should raise_error( SimpleMeasures::InvalidUnitError )
    end

    it "should know aliases for the same unit" do
      SimpleMeasures::Unit.new( 2, :grams ).should == SimpleMeasures::Unit.new( 2, :gram )
    end
  end

  describe "equality" do
    it "should know basic equality" do
      weight1 = SimpleMeasures::Unit.new( 42, :grams )
      weight2 = SimpleMeasures::Unit.new( 42, :grams )

      weight1.should == weight2
    end

    it "should know equality between convertable units" do
      weight1 = SimpleMeasures::Unit.new( 4, :grams )
      weight2 = SimpleMeasures::Unit.new( 4000, :milligrams )

      weight1.should == weight2
    end
  end

  describe "conversion" do
    it "should convert from grams to pounds" do
      weight = SimpleMeasures::Unit.new( 907.18474, :grams )

      weight.convert_to( :pounds ).should == SimpleMeasures::Unit.new( 2, :pounds )
    end

    it "should convert from grams to milligrams" do
      weight = SimpleMeasures::Unit.new( 2, :grams )
      weight.convert_to( :milligrams ).should == SimpleMeasures::Unit.new( 2000, :milligrams )
    end

    it "should have convience methods for the unit" do
      weight = SimpleMeasures::Unit.new( 2, :grams )
      weight.to_milligram.should == SimpleMeasures::Unit.new( 2000, :milligrams )
    end

    it "should have convience methods for the alias" do
      weight = SimpleMeasures::Unit.new( 2, :grams )
      weight.to_milligrams.should == SimpleMeasures::Unit.new( 2000, :milligrams )
    end

    it "blows up if there is not a unit for a convience method" do
      weight = SimpleMeasures::Unit.new( 2, :grams )
      lambda{
        weight.to_blarghs
      }.should raise_error( NoMethodError )
    end

    it "blows up if you try to convert between incompatible types" do
      weight = SimpleMeasures::Unit.new( 2, :grams )
      lambda{
        weight.convert_to(:fl_oz)
      }.should raise_error( SimpleMeasures::ConversionError )
    end
  end

  describe "using coersion" do
    it "is able to multiply" do
      result = 2 * SimpleMeasures::Unit.new( 2,:pounds )
      result.should == SimpleMeasures::Unit.new( 4, :pounds )
    end

    it "is able to divide" do
      result = SimpleMeasures::Unit.new( 8,:pounds ) / 2
      result.should == SimpleMeasures::Unit.new( 4, :pounds )
    end
  end

  describe "addition" do
    it "should be able to add two items of the exact same units" do
      ( SimpleMeasures::Unit.new( 1, :gram ) +
        SimpleMeasures::Unit.new( 1, :gram ) ).should == SimpleMeasures::Unit.new( 2, :grams )
    end

    it "should be able to add two items of the same units with one using an alias" do
      ( SimpleMeasures::Unit.new( 1, :gram ) +
        SimpleMeasures::Unit.new( 2, :grams ) ).should == SimpleMeasures::Unit.new( 3, :grams )
    end

    it "should be able to add two items of different but compatible units" do
      ( SimpleMeasures::Unit.new( 1, :milligram ) +
        SimpleMeasures::Unit.new( 1, :gram ) ).should == SimpleMeasures::Unit.new( 1.001, :grams )
    end

    it "should not be able to add items of different types" do
      lambda {
        SimpleMeasures::Unit.new( 1, :gram ) + SimpleMeasures::Unit.new( 1, :milliliter)
      }.should raise_error(ArgumentError)
    end
  end

  describe "subtraction" do
    it "should be able to subtract two items of the exact same units" do
      ( SimpleMeasures::Unit.new( 5, :gram ) -
        SimpleMeasures::Unit.new( 1, :gram ) ).should == SimpleMeasures::Unit.new( 4, :grams )
    end

    it "should be able to subtract two items of the same units with one using an alias" do
      ( SimpleMeasures::Unit.new( 6, :gram ) -
        SimpleMeasures::Unit.new( 3, :grams ) ).should == SimpleMeasures::Unit.new( 3, :grams )
    end

    it "should be able to subtract two items of different but compatible units" do
      ( SimpleMeasures::Unit.new( 1, :gram ) -
        SimpleMeasures::Unit.new( 1, :milligram ) ).should == SimpleMeasures::Unit.new( 999, :milligrams )
    end

    it "should not be able to subtract items of different types" do
      lambda {
        SimpleMeasures::Unit.new( 1, :gram ) - SimpleMeasures::Unit.new( 1, :milliliter)
      }.should raise_error(ArgumentError)
    end
  end

  describe "hashing" do
    it "is correct so it can be used as a key" do
      five_grams = SimpleMeasures::Unit.new( 5, :gram )
      another_five_grams = SimpleMeasures::Unit.new( 5, :gram )

      hash = {five_grams => 1 }.merge( another_five_grams => 2 )
      hash.keys.size.should == 1
    end
  end
end