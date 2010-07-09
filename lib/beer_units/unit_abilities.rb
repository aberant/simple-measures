module BeerUnits
  module UnitAbilities
    include Comparable

    attr_reader :unit, :value

    def initialize( value, unit )
      raise InvalidUnitError, "Invalid Unit" unless valid_unit?( unit )
      @value = value
      @unit = unit
    end

    def <=>( other )
      other.convert_to(:milligrams).value <=> convert_to(:milligrams).value
    end

    def *( multiplier )
      Weight.new( @value * multiplier, @unit )
    end

    def coerce( other )
      return self, other
    end

    def convert_to( new_unit )
      old_unit = @unit

      new_conversion = fetch_unit_conversion( new_unit )
      old_conversion = fetch_unit_conversion( old_unit )


      old_base = @value * old_conversion.to_f
      new_value = old_base / new_conversion.to_f

      Weight.new( new_value, new_unit )
    end

    def method_missing( meth, *args )
      # TODO: ruby < 1.9 does not have Symbol#match
      super unless meth.match( /^to_/ )

      new_unit = meth.to_s.gsub( 'to_', '' ).to_sym

      convert_to( new_unit )
    end

  private
    def valid_unit?( unit )
      units.keys.include?( unit ) ||
      aliases.keys.include?( unit )
    end

    def fetch_unit_conversion( name )
      units[normalize_unit( name )]
    end

    def normalize_unit( name )
      aliased_name = aliases[name]
      return aliased_name if aliased_name

      return name if units.keys.include?( name )

      raise InvalidUnitError, "Invalid Unit"
    end

    def units() Registry.units; end
    def aliases() Registry.aliases; end
  end
end