# Gives Ruby 1.8.X the Symbol#match method
unless RUBY_VERSION.match(/1.9/)
  class Symbol
    def match( regex )
      self.to_s.match( regex )
    end
  end
end