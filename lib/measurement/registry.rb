module Measurement
  class Registry
    @units = {}
    @aliases = {}

    class << self
      attr_reader :units
      attr_reader :aliases

      def add_unit( unit, value, type )
        @units[unit] = UnitEntry.new( unit, value, type )
      end

      def add_alias( unit, unit_alias )
        raise InvalidAliasError unless valid_unit?( unit )
        @aliases[unit_alias] = unit
      end

      def unit_conversion_value( name )
        unit( name ).value
      end

      def unit_type( name )
        unit( name ).type
      end

      def normalized_unit_name( name )
        aliased_name = @aliases[name]

        return aliased_name if aliased_name
        return name if @units.keys.include?( name )

        raise InvalidUnitError
      end

      def compatible_types?( type_a, type_b )
        unit_type( type_a ) == unit_type( type_b )
      end

      def clear!
        @units = {}
        @alises = {}
      end

      def valid_unit?( unit )
        @units.keys.include?( unit ) || @aliases.keys.include?( unit )
      end

      def smallest_unit_for_type( type )
        units_filtered_by_type = units.find_all{ |unit| unit[1].type == type }
        result = units_filtered_by_type.sort{ |a, b| a[1].value <=> b[1].value }

        # only interested in key, not associated struct
        result[0][0]
      end

    private
      def unit( name )
        @units[normalized_unit_name( name )]
      end
    end
  end
end