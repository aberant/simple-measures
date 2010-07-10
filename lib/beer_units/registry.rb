module BeerUnits
  module Registry
    @units = {}
    @aliases = {}

    class << self
      attr_reader :units
      attr_reader :aliases

      def add_unit( unit, value )
        @units[unit] = value
      end

      def add_alias( unit, unit_alias )
        @aliases[unit_alias] = unit
      end

      def clear!
        @units = {}
        @alises = {}
      end
    end

  end
end