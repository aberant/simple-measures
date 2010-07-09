module BeerUnits
  class Weight
    # everything is stored as milligrams
    add_unit :milligram, 1
    add_unit :gram, 10 ** 3
    add_unit :kilogram, 10 ** 6


    add_alias :milligram, :mg
    add_alias :milligram, :milligrams

    add_alias :gram, :g
    add_alias :gram, :grams

    add_alias :kilogram, :kg
    add_alias :kilogram, :kilograms
  end
end