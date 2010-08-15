# Measurement, all the units you need to describe and convert recipes.
#
# == Authors
#
# * Colin Harris (@aberant on twitter)
#
# == Copyright
#
# Copyright (c) 2010 Colin Harris
#
# This code released under the terms of the MIT license.

require 'simple-measures/registry'
require 'simple-measures/registry/unit_entry'
require 'simple-measures/unit'
require 'simple-measures/core_ext/symbol'

module SimpleMeasures
  VERSION = File.read( File.join( File.dirname( __FILE__ ), "..", "VERSION"))

  class InvalidUnitError < StandardError ; end
  class InvalidAliasError < StandardError ; end
  class ConversionError < StandardError ; end

  def self.use_si_units!() require 'simple-measures/systems/si'; end
  def self.use_imperial_units!() require 'simple-measures/systems/imperial'; end
  def self.use_numeric_sugar!() require 'simple-measures/core_ext/numeric'; end

end

