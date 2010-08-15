# ==========
# = Weight =
# ==========
SimpleMeasures::Registry.add_unit( :milligram, 1, :weight )
SimpleMeasures::Registry.add_unit( :gram, 10 ** 3, :weight )
SimpleMeasures::Registry.add_unit( :kilogram, 10 ** 6, :weight )


SimpleMeasures::Registry.add_alias( :milligram, :milligrams )
SimpleMeasures::Registry.add_alias( :milligram, :mg )

SimpleMeasures::Registry.add_alias( :gram, :grams )
SimpleMeasures::Registry.add_alias( :gram, :g )

SimpleMeasures::Registry.add_alias( :kilogram, :kilograms )
SimpleMeasures::Registry.add_alias( :kilogram, :kg )

# ==========
# = Volume =
# ==========
SimpleMeasures::Registry.add_unit( :milliliter, 1, :volume )
SimpleMeasures::Registry.add_unit( :liter, 10 ** 3, :volume )


SimpleMeasures::Registry.add_alias( :milliliter, :milliliters )
SimpleMeasures::Registry.add_alias( :milliliter, :ml )

SimpleMeasures::Registry.add_alias( :liter, :liters )
SimpleMeasures::Registry.add_alias( :liter, :l )
