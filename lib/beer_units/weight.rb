module BeerUnits
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
      raise "Invalid Unit" unless valid_unit?( unit )
      @value = value
      @unit = unit
    end

    def valid_unit?( unit )
      self.class.units.keys.include?( unit ) ||
      self.class.aliases.keys.include?( unit )
    end

    def <=>( other )
      other.value <=> value
    end

    def method_missing( meth, *args )
      # TODO: ruby < 1.9 does not have Symbol#match
      super unless meth.match(/^to_/)

      new_unit = meth.to_s.gsub('to_', '').to_sym
      old_unit = @unit

      new_conversion = self.class.units[new_unit]
      old_conversion = self.class.units[old_unit]

      old_base = @value * old_conversion.to_f
      new_value = old_base / self.class.units[new_unit].to_f

      return Weight.new(new_value, new_unit)
    end
  end
end
