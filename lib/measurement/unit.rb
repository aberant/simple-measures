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
      raise ArgumentError, "Cannot compare #{unit} to #{other.unit}" unless Registry.compatible_types?( unit, other.unit)

      smallest_common_unit = Registry.smallest_unit_for_type( Registry.unit_type( unit) )
      other.convert_to( smallest_common_unit ).value <=> convert_to( smallest_common_unit ).value
    end

    def *( multiplier )
      Unit.new( @value * multiplier, @unit )
    end

    def +( other )
      raise ArgumentError, "Cannot add #{unit} to #{other.unit}" unless Registry.compatible_types?( unit, other.unit)

      Unit.new( value + other.value, unit )
    end

    def -( other )
      raise ArgumentError, "Cannot add #{unit} to #{other.unit}" unless Registry.compatible_types?( unit, other.unit)

      Unit.new( value - other.value, unit )
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