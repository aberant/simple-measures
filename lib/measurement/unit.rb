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
      # we have to make some compromises here
      # sometimes floats appear equal, but a bagillionth decimal place later
      # there is some mystery number that screws this up.  thus we chop it off after the thousandths place.

      # please enquire about the "enterprise" license which will give you precision to the ten thousandths place
      other_value = ( other.convert_to( smallest_common_unit ).value * 1000 ).round
      self_value = ( convert_to( smallest_common_unit ).value * 1000 ).round

      other_value <=> self_value
    end

    def *( multiplier )
      case multiplier
      when Numeric
        Unit.new( @value * multiplier, @unit )
      else
        raise ArgumentError, "Only able to acecpt Numeric types for multiplication"
      end
    end

    def /( divisor )
      case divisor
      when Numeric
        Unit.new( @value / divisor, @unit )
      else
        raise ArgumentError, "Only able to acecpt Numeric types for division"
      end
    end

    def +( other )
      raise ArgumentError, "Only able to add Measurement::Unit objects" unless other.class == Measurement::Unit
      raise ArgumentError, "Cannot add #{unit} to #{other.unit}" unless Registry.compatible_types?( unit, other.unit )

      converted_self = convert_to( smallest_common_unit ).value
      converted_other = other.convert_to( smallest_common_unit ).value

      Unit.new( converted_self + converted_other, smallest_common_unit )
    end

    def -( other )
      raise ArgumentError, "Only able to subtract Measurement::Unit objects" unless other.class == Measurement::Unit
      raise ArgumentError, "Cannot add #{unit} to #{other.unit}" unless Registry.compatible_types?( unit, other.unit )

      converted_self = convert_to( smallest_common_unit ).value
      converted_other = other.convert_to( smallest_common_unit ).value

      Unit.new( converted_self - converted_other, smallest_common_unit )

    end

    def coerce( other )
      return self, other
    end

    def convert_to( new_unit )
      raise ConversionError, "Cannot convert #{unit} to #{new_unit}" unless Registry.compatible_types?( unit, new_unit )

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

  private
    def smallest_common_unit
      Registry.smallest_unit_for_type( Registry.unit_type( unit) )
    end
  end
end