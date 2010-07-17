require 'measurement/registry'
require 'measurement/registry/unit_entry'
require 'measurement/unit'
require 'measurement/core_ext/numeric'
require 'measurement/core_ext/symbol'

module Measurement
  class InvalidUnitError < StandardError ; end
  class InvalidAliasError < StandardError ; end
end

