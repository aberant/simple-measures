class Numeric
  def method_missing( meth, *args )
    unit = meth
    super unless Measurement::Registry.valid_unit?( unit )

    Measurement::Unit.new( self, unit )
  end
end