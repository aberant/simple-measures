module BeerUnits
  class InvalidUnitError < StandardError ; end

  class Weight
    include Comparable

    @units = {}
    @aliases = {}

    attr_reader :unit, :value

    class << self
      attr_reader :units
      attr_reader :aliases

      def add_unit( unit, value )
        @units[unit] = value
      end

      def add_alias( unit, unit_alias )
        @aliases[unit_alias] = unit
      end
    end

    def initialize( value, unit )
      raise InvalidUnitError, "Invalid Unit" unless valid_unit?( unit )
      @value = value
      @unit = unit
    end

    def valid_unit?( unit )
      self.class.units.keys.include?( unit ) ||
      self.class.aliases.keys.include?( unit )
    end

    def fetch_unit_conversion( name )
      self.class.units[name]
    end

    def <=>( other )
      other.value <=> value
    end

    def *( multiplier )
      Weight.new( @value * multiplier, @unit )
    end

    def coerce( other )
      return self, other
    end

    def method_missing( meth, *args )
      # TODO: ruby < 1.9 does not have Symbol#match
      super unless meth.match( /^to_/ )

      new_unit = meth.to_s.gsub( 'to_', '' ).to_sym
      old_unit = @unit

      new_conversion = fetch_unit_conversion( new_unit )
      old_conversion = fetch_unit_conversion( old_unit )

      old_base = @value * old_conversion.to_f
      new_value = old_base / fetch_unit_conversion( new_unit ).to_f

      return Weight.new( new_value, new_unit )
    end
  end
end
