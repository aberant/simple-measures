require 'spec/rake/spectask'

task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.libs << 'lib'
  t.warning = false
  t.rcov = false
  t.spec_opts = ["--colour"]
end