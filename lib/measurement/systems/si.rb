# ==========
# = Weight =
# ==========
Measurement::Registry.add_unit( :milligram, 1, :weight )
Measurement::Registry.add_unit( :gram, 10 ** 3, :weight )
Measurement::Registry.add_unit( :kilogram, 10 ** 6, :weight )


Measurement::Registry.add_alias( :milligram, :milligrams )
Measurement::Registry.add_alias( :milligram, :mg )

Measurement::Registry.add_alias( :gram, :grams )
Measurement::Registry.add_alias( :gram, :g )

Measurement::Registry.add_alias( :kilogram, :kilograms )
Measurement::Registry.add_alias( :kilogram, :kg )

# ==========
# = Volume =
# ==========
Measurement::Registry.add_unit( :milliliter, 1, :volume )
Measurement::Registry.add_unit( :liter, 10 ** 3, :volume )


Measurement::Registry.add_alias( :milliliter, :milliliters )
Measurement::Registry.add_alias( :milliliter, :ml )

Measurement::Registry.add_alias( :liter, :liters )
Measurement::Registry.add_alias( :liter, :l )
