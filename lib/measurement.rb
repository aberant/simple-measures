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

require 'measurement/registry'
require 'measurement/registry/unit_entry'
require 'measurement/unit'
require 'measurement/core_ext/numeric'
require 'measurement/core_ext/symbol'

module Measurement
  VERSION = File.read( File.join( File.dirname( __FILE__ ), "..", "VERSION"))


  class InvalidUnitError < StandardError ; end
  class InvalidAliasError < StandardError ; end
  
  def self.use_si_units!() require 'measurement/systems/si'; end
  def self.use_imperial_units!() require 'measurement/systems/imperial'; end
  
  
end

