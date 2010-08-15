# ==========
# = Weight =
# ==========
SimpleMeasures::Registry.add_unit( :pound, 453_592.37, :weight )
SimpleMeasures::Registry.add_unit( :ounce, 28_349.5231, :weight )


SimpleMeasures::Registry.add_alias( :pound, :pounds )
SimpleMeasures::Registry.add_alias( :pound, :lb )
SimpleMeasures::Registry.add_alias( :pound, :lbs )

SimpleMeasures::Registry.add_alias( :ounce, :ounces )
SimpleMeasures::Registry.add_alias( :ounce, :oz )

# ==========
# = Volume =
# ==========
SimpleMeasures::Registry.add_unit( :fluid_ounce, 29.5735296, :volume )
SimpleMeasures::Registry.add_unit( :cup, 236.588237, :volume )
SimpleMeasures::Registry.add_unit( :pint, 473.176473, :volume )
SimpleMeasures::Registry.add_unit( :quart, 946.352946, :volume )
SimpleMeasures::Registry.add_unit( :gallon, 3_785.41178, :volume )

SimpleMeasures::Registry.add_alias( :fluid_ounce, :floz )
SimpleMeasures::Registry.add_alias( :fluid_ounce, :ozfl )
SimpleMeasures::Registry.add_alias( :cup, :cups )
SimpleMeasures::Registry.add_alias( :pint, :pints )
SimpleMeasures::Registry.add_alias( :quart, :quarts )
SimpleMeasures::Registry.add_alias( :quarts, :qt )
SimpleMeasures::Registry.add_alias( :gallon, :gallons )
SimpleMeasures::Registry.add_alias( :gallon, :gal )
