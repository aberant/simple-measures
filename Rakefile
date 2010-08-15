require 'spec/rake/spectask'

task :default => :spec

Spec::Rake::SpecTask.new do |t|
  t.libs << 'lib'
  t.warning = false
  t.rcov = false
  t.spec_opts = ["--colour"]
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "Measurement #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'rake/packagetask'
require 'rake/gempackagetask'

### Task: gem
gemspec = Gem::Specification.new do |gem|
  gem.name      = "simple-measures"
  gem.version   = File.read('VERSION')

  gem.summary     = "SimpleMeasures - simple unit conversions for everyday things"
  gem.description = "SimpleMeasures is an easy and extensible measurement conversion library"

  gem.authors  = "Colin Harris"
  gem.email    = "qzzzq1@gmail.com"
  gem.homepage = "http://github.com/aberant/simple-measures"

  gem.has_rdoc = true

  gem.files        = FileList['Rakefile', 'README.rdoc', 'VERSION', 'LICENSE', 'lib/**/*'].to_a
  gem.test_files   = FileList['spec/**/*.rb']
end

Rake::GemPackageTask.new( gemspec ) do |task|
  task.gem_spec = gemspec
  task.need_tar = false
  task.need_tar_gz = true
  task.need_tar_bz2 = true
  task.need_zip = true
end