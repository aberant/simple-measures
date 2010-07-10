class Numeric
  def oz
    Weight.from_oz( self )
  end

  def lbs
    Weight.from_lbs( self )
  end

  alias :lb :lbs
end