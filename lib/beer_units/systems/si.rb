module BeerUnits
  class SI
    def self.setup
      # everything is stored as milligrams
      BeerUnits::Weight.add_unit :milligram, 1
      BeerUnits::Weight.add_unit :gram, 10 ** 3
      BeerUnits::Weight.add_unit :kilogram, 10 ** 6


      BeerUnits::Weight.add_alias :milligramgram, :mg
      BeerUnits::Weight.add_alias :milligramgram, :milligrams

      BeerUnits::Weight.add_alias :gram, :g
      BeerUnits::Weight.add_alias :gram, :grams

      BeerUnits::Weight.add_alias :kilogram, :kg
      BeerUnits::Weight.add_alias :kilogram, :kilograms
    end
  end
end