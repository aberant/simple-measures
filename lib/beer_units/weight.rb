module BeerUnits
  class Weight
    OZ_2_GRAMS = 28.3495231

    def self.from_oz( oz )
      new( oz * OZ_2_GRAMS )
    end

    def self.from_lbs( lbs )
      from_oz( lbs * 16 )
    end

    def initialize( grams )
      @grams = grams
    end

    def in_grams
      self
    end

    def in_oz
      @grams / OZ_2_GRAMS
    end

    def in_lbs
      in_oz / 16
    end

    alias :in_lb :in_lbs

    def to_s
      inspect
    end

    def inspect
      "grams: #{@grams.inspect}"
    end
  end
end