require 'beer_measurement/registry'
require 'beer_measurement/unit'
require 'beer_measurement/core_ext/numeric'

module BeerMeasurement
  class InvalidUnitError < StandardError ; end
  class InvalidAliasError < StandardError ; end
end

