class Numeric
  def method_missing( meth, *args )
    unit = meth
    super unless SimpleMeasures::Registry.valid_unit?( unit )

    SimpleMeasures::Unit.new( self, unit )
  end
end