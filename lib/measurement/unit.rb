module Measurement
  class Unit
    include Comparable

    attr_reader :unit, :value

    def initialize( value, unit )
      raise InvalidUnitError, "Invalid Unit" unless Registry.valid_unit?( unit )
      @value = value
      @unit = unit
    end

    def <=>( other )
      other.convert_to(:milligrams).value <=> convert_to(:milligrams).value
    end

    def *( multiplier )
      Unit.new( @value * multiplier, @unit )
    end

    def coerce( other )
      return self, other
    end

    def convert_to( new_unit )
      old_unit = @unit

      new_conversion = Registry.unit_conversion_value( new_unit )
      old_conversion = Registry.unit_conversion_value( old_unit )


      old_base = @value * old_conversion.to_f
      new_value = old_base / new_conversion.to_f

      Unit.new( new_value, new_unit )
    end

    def method_missing( meth, *args )
      super unless meth.match( /^to_/ )

      new_unit = meth.to_s.gsub( 'to_', '' ).to_sym
      super unless Registry.valid_unit?( new_unit )

      convert_to( new_unit )
    end
  end
end