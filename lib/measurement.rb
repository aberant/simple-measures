require 'measurement/registry'
require 'measurement/unit'
require 'measurement/core_ext/numeric'

module Measurement
  class InvalidUnitError < StandardError ; end
  class InvalidAliasError < StandardError ; end
end

