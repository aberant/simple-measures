# ==========
# = Weight =
# ==========
Measurement::Registry.add_unit( :pound, 453_592.37, :weight )
Measurement::Registry.add_unit( :ounce, 28_349.5231, :weight )


Measurement::Registry.add_alias( :pound, :pounds )
Measurement::Registry.add_alias( :pound, :lb )
Measurement::Registry.add_alias( :pound, :lbs )

Measurement::Registry.add_alias( :ounce, :ounces )
Measurement::Registry.add_alias( :ounce, :oz )

# ==========
# = Volume =
# ==========
Measurement::Registry.add_unit( :fluid_ounce, 29.5735296, :volume )
Measurement::Registry.add_unit( :pint, 473.176473, :volume )
Measurement::Registry.add_unit( :quart, 946.352946, :volume )
Measurement::Registry.add_unit( :gallon, 3_785.41178, :volume )

Measurement::Registry.add_alias( :fluid_ounce, :floz )
Measurement::Registry.add_alias( :fluid_ounce, :ozfl )

Measurement::Registry.add_alias( :pint, :pints )
Measurement::Registry.add_alias( :quart, :quarts )
Measurement::Registry.add_alias( :quarts, :qt )
Measurement::Registry.add_alias( :gallon, :gallons )
Measurement::Registry.add_alias( :gallon, :gal )
