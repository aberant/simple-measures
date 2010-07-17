watch( 'spec/.*_spec\.rb' )  {|md| system("rake spec") }
watch( 'lib/(.*)\.rb' )      {|md| system("rake spec") }